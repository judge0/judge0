# judge0 — Newton School fork

Rails 5.2 API for sandboxed code execution. Forked from `judge0/judge0`
(upstream v1.13). Layered on top of `newtonschool/judge0-newton-compiler`
(see `Newton-School/compilers`) which provides every compiler/interpreter
plus the `isolate` sandbox.

## Stack

| Component | Version | Why |
|---|---|---|
| App runtime Ruby | **2.7.8** | Stays on Rails 5.2; OpenSSL 1.1.1w is built inline because bookworm only ships OpenSSL 3 and Ruby 2.7's bundled openssl extension can't build against 3 |
| Rails | 5.2.4.3 | Frozen — major upgrade out of scope of current modernisation |
| Postgres | 13 (dev) | Production uses managed Postgres |
| Redis | 6.0 + 6.2.6 sidecar | sidecar = secondary cache (separate db) |
| Resque + Resque-scheduler | 2.0 / 4.4 | submission queue |
| Compiler base | `newtonschool/judge0-newton-compiler:c51f91f531a5…` (label 0.40) | what we layer on; compilers CI tags by commit SHA, not semver |
| Sandbox | `isolate` v2.0 in **cgroup v2 mode** (`docker-entrypoint.sh` sets up the hierarchy at startup) | from compilers image |

The Rails app's Ruby (`/usr/local/ruby-2.7.8`, installed in
`NewtonDockerfile`) is **decoupled** from the Ruby that student
submissions use (`/usr/local/ruby-3.3.6`, language id 72, comes from the
compilers image). Don't conflate them.

## Repo layout you will care about

```
.
├── Dockerfile                       # upstream layout, frozen
├── NewtonDockerfile                 # Newton's production image — USE THIS
├── docker-compose.dev.yml           # dev-only stack; prod deploys the single image
├── docker-entrypoint.sh             # `cron && exec "$@"` — keeps cron alive
├── judge0.conf                      # all sandbox knobs (memory, time, processes, file size)
├── scripts/
│   ├── server                       # `rails db:create db:migrate db:seed && rails s`
│   ├── workers                      # `rake resque:scheduler && rake resque:workers`
│   ├── load-config                  # sources judge0.conf, sets RAILS env
│   └── dev/{shell,bundle,clean,...} # dev helpers
├── bin/
│   ├── newton-smoke-test            # end-to-end smoke, every active language id (39 checks on amd64)
│   ├── newton-postman.json          # Postman mirror of newton-smoke-test (same sections + case names)
│   ├── newton-bounds-test           # HELLO / TLE / OOM enforcement probes, sync + async
│   ├── lint-active-rb               # active.rb + archived.rb lint (also runs at image build)
│   └── agricius                     # release tarball generator (rare use)
├── db/
│   ├── languages/active.rb          # canonical language id → command map
│   ├── languages/archived.rb        # historical/dropped languages
│   ├── languages/helpers/           # sandbox-side compile helpers → /usr/local/bin (3010)
│   ├── seeds.rb                     # loads active.rb + archived.rb into DB
│   └── migrate/                     # rails migrations (don't add new ones lightly)
├── app/jobs/isolate_job.rb          # the sandbox runner — most complex Ruby in the repo
├── app/controllers/submissions_controller.rb
├── cron/{clear_cache,telemetry}     # baked-in cron entries; expect /api/tmp/environment from scripts/load-config
└── config/                          # standard Rails 5 config layout
```

## Languages: how a submission flows

1. `POST /submissions` → `submissions_controller.rb` validates + persists.
2. Resque enqueues `IsolateJob` with the submission token.
3. `IsolateJob#perform`:
   - Calls `isolate -b <id> --init` to create `/var/local/lib/isolate/<id>/box`.
   - Writes the source from `submission.source_code` to `box/<source_file>`.
   - Runs the language's `compile_cmd` (if any) inside isolate via `--run`.
   - Runs the `run_cmd` inside isolate.
   - Captures stdout/stderr/metadata.
   - `isolate --cleanup` afterwards.
4. The submission row's `status_id` is updated; the API returns it.

`db/languages/active.rb` is the **single source of truth** for which
language ids exist and what they invoke. Editing it requires a
`rails db:seed` to take effect (which `scripts/server` runs on startup).

## Per-language tuning conventions

- **C / Fortran compile commands** carry lenient flags so GCC-9-era
  student code still compiles on GCC 14 (which promoted four warnings to
  errors). Don't strip these:
  ```
  -Wno-error=implicit-function-declaration
  -Wno-error=implicit-int
  -Wno-error=int-conversion
  -Wno-error=incompatible-pointer-types
  ```
  And `-fallow-argument-mismatch` for Fortran (gfortran 10+ broke
  argument-mismatch tolerance).
- **JVM-based languages** (Java, MARS) pass `-XX:ActiveProcessorCount=2`
  (or set `JAVA_OPTS` for launcher scripts). Without this the JVM sees
  host nproc and spawns threadpools that hit `RLIMIT_NPROC` inside the
  sandbox → `pthread_create EAGAIN`.
- **Kotlin compile (id 78)** carries explicit JVM heap caps via `-J`
  flags on `kotlinc`:
  ```
  -J-Xmx384m -J-XX:MaxMetaspaceSize=80m -J-XX:ReservedCodeCacheSize=32m -J-XX:+UseSerialGC
  ```
  Reason: `IsolateJob#compile` hardcodes the compile cgroup's
  `--cg-mem` to `Config::MAX_MEMORY_LIMIT` (NOT the per-submission
  `memory_limit`), so the compile step is fixed at 500 MB on staging.
  Default G1GC + uncapped metaspace pushes total JVM footprint past
  500 MB even on hello-world and the cgroup OOM-killer SIGKILLs the
  java subprocess. UseSerialGC is not optional — it's the difference
  between a ~480 MB and a ~600 MB resident footprint.
- **GCC id 50 (C) / 54 (C++)** are the only C/C++ toolchain entries in
  active.rb (both point to `/usr/local/gcc-9.5.0/...`). Ids 3003/3004
  (GCC 14) live in `archived.rb`. See `compilers/CLAUDE.md` for why the
  image ships only 9.5.
- **Verilog id 3005 (Icarus 13.0)** uses an unusual two-file submission
  model: `source_code` is the student's DUT, `stdin` is the
  instructor-supplied testbench. `compile_cmd` parse-checks the DUT
  alone with `iverilog -tnull` (so DUT syntax errors go to the Compile
  Error bucket); `run_cmd` does `cat > tb.v && iverilog ... && vvp ...`
  and forwards vvp's stdout verbatim — no filtering. Problem authors
  must capture `expected_output` by running their testbench and
  including everything vvp prints, including the
  `tb.v:N: $finish called at T (1s)` epilogue (or use `$finish(0);` in
  the testbench to suppress that line at source). Full design rationale
  in `docs/superpowers/specs/2026-05-02-iverilog-integration-design.md`.
- **C# .NET 7 / .NET 8 (ids 3007/3008).** dotnet on Linux uses a W^X
  double-mapped JIT code allocator that calls `memfd_create` +
  `ftruncate` to reserve a code cache sized from host RAM. On EC2 prod
  that reservation exceeds isolate's `RLIMIT_FSIZE` and kills dotnet
  with SIGXFSZ during runtime init — before any user-visible output.
  Fix: `DOTNET_EnableWriteXorExecute=0` lives in the compiler image's
  Tier 12 ENV (compiler 0.33+); the per-language `env:` array on each
  .NET record (see "Per-language env propagation" below) declares it
  alongside `DOTNET_NOLOGO` and `DOTNET_CLI_TELEMETRY_OPTOUT`, and
  `IsolateJob` re-exposes those names to the sandbox via `-E NAME` on
  both compile and run. Without that propagation isolate strips them.
  Diagnostic fingerprint when broken: compile exits 153 (=128+25=
  SIGXFSZ) with empty stdout/stderr. Mono (3006) uses a different
  runtime and ships no `env:` array.
- **Per-language env propagation (`env:` on active.rb).** Languages
  with runtime-specific environment needs (e.g. .NET's
  `DOTNET_EnableWriteXorExecute`) declare an `env:` array of bare env
  var NAMES on their `active.rb` record. `IsolateJob#language_env_flags`
  expands those into `-E NAME` flags, splicing them into both compile
  and run isolate commands. Values are sourced from the compiler
  image's Dockerfile ENV — `active.rb` only declares which names to
  propagate (the NAME-only form, not `NAME=value`). Validation
  (`EnvValidator`) runs at seed time and via `bin/lint-active-rb`:
  must be an Array of String, each entry a POSIX-style env var name
  (`[A-Za-z_][A-Za-z0-9_]*` — mixed case allowed because .NET names
  aren't all-uppercase). Languages with no env requirements simply
  omit the key.
- **Submission assets (Phase 3, new in 0.67).** Languages may declare
  an `assets:` array in `active.rb` (Verilog 3005 declares `wave.vcd`
  with regex `\.vcd$`). After `run_cmd` exits, `IsolateJob` calls
  `AssetCapture` to glob the box for matching files and persist them
  as `submission_assets` rows (base64 in a `text` column, capped per
  declaration / `MAX_MAX_ASSET_SIZE`). Two-level decision: per-call
  opt-out via `skip_assets: true` in the POST body, plus implicit
  per-language opt-in (no `assets:` array → no capture work).
  Validation runs at seed time (fails container boot on bad regex)
  and via `bin/lint-active-rb` (CI gate). API: extended submission
  GET returns asset metadata when `fields=...,assets`; bytes via
  `GET /submissions/:token/assets/:logical_name`. Full design in
  `docs/superpowers/specs/2026-05-05-submission-assets-design.md`.
- **C + Lex/Yacc id 3010 (compiler-design lab).** `source_code` is a
  *bundle*: every file starts with a marker line
  `/* ==== FILE: name.ext ==== */` (`.l .y .c .h`, at most one `.l` and
  one `.y`; no marker = the whole buffer is one lex spec, compiled as
  `main.l`). `stdin` is the input fed to `./a.out`. `compile_cmd` is just
  `/usr/local/bin/newton-cdlab-build %s`: it splits the bundle **inside
  the sandbox** with the generic `newton-bundle-split`, then runs
  `bison -y -d` → `flex` → GCC 9.5 with id 50's lenient flags (+
  `compiler_options`, `-ly`/`-lfl`/`-lm`). Both helpers live in
  `db/languages/helpers/`; `NewtonDockerfile` installs them to
  `/usr/local/bin` (isolate mounts `/usr`, not `/api`) and runs
  `newton-cdlab-selftest`, which needs compilers Tier 15 (label 0.39+) —
  the build fails on an older base by design. `compile_output` is a
  stage log: `==> bison -y -d yFile3.y` etc. appears only for a stage
  that printed something or failed, and diagnostics carry bare file names
  (`yFile3.y:42`) matching the marker names. Contract rules:
  - The build drops exactly **one** leading empty line, so a bundle may
    start with one newline; marker-less flex errors then say `main.l:N`
    for line N of the text after it. Other blank lines before the first
    marker are ignored; any other text there is a Compilation Error
    ("text before the first file marker"), so once any marker is present
    every file must start with one.
  - A line that *looks* like a marker (`/*`, some `=`, `FILE` in any case,
    `:`; also with a no-break space or fullwidth `=`/`:`) but is not exact
    is a hard error, never content — so a banner comment like
    `/*===== File: scanner.l =====*/` fails the build; the message says
    to reword it.
  - bison `%skeleton` is refused (bison runs the named file through m4,
    which could run shell commands at compile time).
  - Capture `expected_output` by running the reference solution through
    3010 (the lab handout's sample output is not reproducible as written).

  Keep `%` out of `compile_cmd` apart from the single `%s` —
  `bin/lint-active-rb` checks it (it runs at image build; CI has no PR
  job, so run it locally before merging).

- **CircuitRun ESP32-S3 DevKitC-1 id 3011.** Same stdin payload and asset
  names as 3009, each asset with a 1 MiB `max_size` (production's
  `MAX_MAX_ASSET_SIZE` of 40960 bytes caps it). `compile_cmd` builds
  the firmware (`build/firmware.bin`, a 4 MiB flash image) under judge0's
  `MAX_*` limits with no stdin, and `run_cmd` boots it in the CircuitRun
  dist's patched QEMU (`qemu-system-xtensa`) and grades it. A sketch error
  is a Compilation Error with gcc's `main.ino:<line>:` text. Needs a
  compilers image whose Tier 13 pins the Uno + ESP32-S3 dist (label 0.40+).
  The compile needs `MAX_MAX_FILE_SIZE` of at least 8192 KB (blink fails
  at 4096 KB). Under `MAX_MEMORY_LIMIT` (512000 KB on the public prod
  stack) blink, a `<bits/stdc++.h>` sketch with a few containers and a
  `std::regex` sketch compile; one combining `<bits/stdc++.h>`,
  `std::regex`, `std::wregex` and about ten containers goes over and fails
  as a Compilation Error (`Killed signal terminated program cc1plus`).
  Measured on arm64.

## Build commands

```bash
# arm64 (Mac dev)
docker buildx build --platform linux/arm64 \
  -f NewtonDockerfile -t newtonschool/newton-judge0:0.76 --load .

# amd64 (EC2 / prod)
docker buildx build --platform linux/amd64 \
  -f NewtonDockerfile -t newtonschool/newton-judge0:0.76 --load .
```

A full build takes ~15-20 min (most of it is OpenSSL 1.1 + Ruby 2.7.8
from source; the rest is bundle install).

## Dev workflow

Build the image first (see Build commands above; re-run only when
`Gemfile` or `NewtonDockerfile` changes). Then bring up the stack —
`docker-compose.dev.yml` includes nginx and resque-web images that are
old and may not start on current Docker Desktop, so skip those:

```bash
# Essentials only (skip nginx + resque-web + pgbouncer)
docker compose -f docker-compose.dev.yml up -d judge0 db redis redis-sidecar

# Start workers in the judge0 container (separate exec session)
docker compose -f docker-compose.dev.yml exec -d --privileged judge0 \
  bash -c 'source /api/scripts/load-config; cd /api && rake resque:workers QUEUE=*'

# Hit the API
curl http://localhost:2358/languages | jq

# Tear down (drops volumes)
docker compose -f docker-compose.dev.yml down -v
```

The host repo bind-mounts at `/api` inside the container, so editing
Ruby/Rails code is live (no rebuild needed for code-only changes; only
binaries — Ruby version, gems via `bundle install`, etc. — need a rebuild).

## End-to-end smoke test

```bash
JUDGE0_URL=http://localhost:2358 ./bin/newton-smoke-test
```

Submits a hello-world or equivalent behavioral smoke for every active language
id. Expected after `man` support on top of 0.76, plus the four 3010 cases
and 3011's three (accepted, its result asset, a compile error):
**39 PASS / 0 FAIL / 0 SKIP** on amd64; **37 PASS / 0 FAIL / 2 SKIP** on
arm64 (NASM and FreeBASIC are amd64-only upstream). Verilog waveforms and
CircuitRun result artifacts each add an asset-metadata PASS; the Bash lane
contributes three (hello-world, `man`, `whatis`).

Two companions move with the smoke test when a language is added:
`bin/newton-postman.json` mirrors its cases as importable Postman requests
(folders follow the smoke sections, same case names), and
`bin/newton-bounds-test` probes HELLO / TLE (`cpu_time_limit=1`) / OOM
(64 MB cap, 200 MB alloc) per language in sync and async mode — 68 probes
per mode with 3011 (25 HELLO + 24 TLE + 18 OOM + 1 CircuitRun 3009 low-memory).

**Plain-text API mode cannot return non-ASCII output.** judge0 stores
stdout/stderr/compile_output base64-encoded and decodes them as binary,
so without `base64_encoded=true` any byte above 0x7F fails the response
("cannot be converted to UTF-8", HTTP 201 with only `token` + `error`).
The compiler image runs with `LC_ALL=en_US.UTF-8`, so gcc/bison
diagnostics quote with `‘…’` and every compile error trips this. Always
send `base64_encoded=true`; smoke checks that read compile errors
(`t_ce`, and the Postman grammar-error request) do.

Rspec tests in `spec/` are mostly upstream — Newton has not added
comprehensive specs. Don't rely on `bundle exec rspec` for end-to-end
validation; use `bin/newton-smoke-test`.

## judge0.conf knobs

`judge0.conf` is the dev/local config only — `.dockerignore` keeps it out
of the image. Production runs two separate stacks configured from k8s
secrets: `judge0-config` (judge0-api/-worker, private, cluster-internal)
and `judge0-public-config` (judge0-public-api/-worker, public,
`https://judge0-public.newtonschool.co`), each
with its own Postgres that re-seeds `languages` on boot. A new language
must reach both stacks, and smoke tests should hit both endpoints.

Newton overrides on top of upstream defaults. Comments inline
in `judge0.conf` explain each. Summary:

| Setting | Default | Newton | Why |
|---|---|---|---|
| `ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT` | false | `${OVERRIDE_PER_PROCESS_TIME:-true}` → flipped to `false` by `docker-entrypoint.sh` when cgroup-v2 setup succeeds, so `IsolateJob` adds `--cg` and isolate uses `cpu.stat` / `memory.max` (RSS) instead of `RLIMIT_CPU` / `RLIMIT_AS` |
| `ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT` | false | same — flipped at runtime, gives RSS-based memory limits required for DSA per-question caps to be meaningful for JVM/Node/Python ML |
| `MEMORY_LIMIT` | 128 MB | **8 GiB** | JVM 21 + Node 22 + numpy each pre-reserve >1 GiB |
| `MAX_MEMORY_LIMIT` | 512 MB | **16 GiB** | per-submission memory_limit cap |
| `MAX_PROCESSES_AND_OR_THREADS` | 60 | **2048** | JVM/Node thread pools |
| `MAX_MAX_PROCESSES_AND_OR_THREADS` | 120 | **4096** | compile-time max |
| `MAX_FILE_SIZE` | 1 MB | **1 GiB** | Go 1.23 binaries + Java class+jar bundles can exceed 1 MB |
| `MAX_MAX_FILE_SIZE` | 4 MB | **2 GiB** | per-submission max |
| `MAX_MAX_ASSET_SIZE` | – (new in 0.67) | **20480** (20 KB) | Phase 3 asset cap; clamps any per-language `max_size` |

## Common pitfalls

1. **Compose env vars are overridden by `judge0.conf`.** `scripts/load-config`
   does `set -o allexport; source $CONFIG_FILE` which clobbers anything you
   pass via `docker-compose environment:`. Edit `judge0.conf` for sandbox
   tuning, not compose env.
2. **isolate `--cg` mode normally requires `isolate-cg-keeper` (systemd
   service) to populate `/run/isolate/cgroup`** — not available in
   non-systemd containers. `docker-entrypoint.sh` substitutes for it: at
   startup it lays out `/sys/fs/cgroup/{api.scope,isolate.slice}`, enables
   `subtree_control`, and writes `/run/isolate/cgroup` pointing at
   `isolate.slice`. The "no internal process constraint" is sidestepped
   by moving Rails/Resque into `api.scope` first. If that setup fails
   (cgroup v1 host, non-privileged container), the entrypoint falls back
   silently to rlimit mode.
3. **isolate command in `app/jobs/isolate_job.rb` doesn't expose `-O`
   (open files).** R and Go submissions hit RLIMIT_NOFILE. Adding it
   would mean editing IsolateJob and adding a `MAX_OPEN_FILES` knob to
   `judge0.conf` — a future PR.
4. **`gem 'rails', '~> 5.0'` is intentional.** Bumping to Rails 6/7
   forces a Ruby 3+ migration; we deliberately decoupled student-facing
   Ruby (3.3.6 in compilers image) from app-runtime Ruby (2.7.8) so the
   Rails upgrade can be its own project.
5. **bookworm's `/etc/apt/trusted.gpg.d/*.asc` is occasionally unparsable
   by gpgv** in some Docker Desktop / buildkit environments — `apt-get
   update` fails with "At least one invalid signature was encountered".
   `NewtonDockerfile` has a conditional `[trusted=yes]` fallback that
   activates only when this happens (silent on EC2 builds where apt
   verification works fine). The TLS layer to deb.debian.org still
   authenticates the mirror.
6. **`ennexa/resque-web:latest` ships an obsolete v1 manifest** that
   modern Docker rejects. Don't include it when bringing up the dev
   stack. The Resque jobs themselves run fine without the web UI.
7. **db/languages/active.rb path conventions matter.** Paths must point
   to what the compilers image actually ships. Rebuilding compilers
   without rebuilding judge0 (or vice versa) and forgetting to bump
   the FROM tag in `NewtonDockerfile` means submissions fail with "no
   such file or directory" mid-execution.

## Image is published as

- Docker Hub: `newtonschool/newton-judge0`
- Current tag: **`0.76`** — adds three C# lanes on compiler 0.33:
  3006 Mono 6.12, 3007 .NET 7.0.400, 3008 .NET 8.0.302. Compiler base
  bumped 0.29 → 0.33 (which carries `DOTNET_EnableWriteXorExecute=0`
  for the W^X / RLIMIT_FSIZE workaround), propagated into isolate via
  `-E DOTNET_EnableWriteXorExecute` in `IsolateJob`. Smoke target
  was 28/0/0 at 0.76; it is 39/0/0 on amd64 with lanes 3010 and 3011 (see
  "End-to-end smoke test").
- **The compiler base is pinned by commit SHA, not semver.** The compilers
  workflow pushes `judge0-newton-compiler:<git-sha>` and `:latest` only; the
  `0.35`/`0.36` tags on Docker Hub were hand-pushed months ago, and the
  `0.x` numbering lives solely in that repo's
  `org.opencontainers.image.version` label — a semver tag for a new build
  will not exist. `NewtonDockerfile` pins
  `c51f91f531a575827231b61f0148a7a5d36d451a` (Newton-School/compilers#26,
  label 0.40: CircuitRun ESP32-S3 for lane 3011), pushed by the compilers
  workflow as `:<sha>` and `:latest` (digest `sha256:526537d7…`). It sits
  on #23 (label 0.39: Tier 15 flex/bison/libfl/liby for lane 3010, built by
  hand on the build box as `:f8f215eac832…` and `:0.39`, digest
  `sha256:e7ffeab5…`), on #22, which caps CircuitRun's arduino-cli at
  `--jobs 4` / `GOMAXPROCS=4` so Arduino builds fit isolate's
  RLIMIT_NPROC, and #21, which added man-db for the Bash lane. CI here
  likewise tags by SHA (CodeBuild pushes ECR `judge0:<git-sha>`, the staging
  workflow Docker Hub `newton-judge0:<git-sha>`, each plus `:latest`), so the
  version numbers elsewhere in this file are a local-build convention rather
  than anything CI produces.
- Production is two stacks (see "judge0.conf knobs"), each pinned to an
  ECR image by git SHA (`405612465938.dkr.ecr.ap-south-1.amazonaws.com/judge0:<sha>`,
  set in kubernetes-cluster-infra `clusters/newton-core/base/code-compiler/deployment.yaml`).
  As of 2026-10-17 both stacks (`judge0-public-api/-worker` and
  `judge0-api/-worker`) run `judge0:f4dd691cea8c…` (lane 3010 on compiler
  base f8f215e / label 0.39; smoke 36/0/0 against
  `https://judge0-public.newtonschool.co`), and staging runs the same SHA.
  Prod ECR images are built by the AWS CodeBuild project `judge0` (prod
  account, `buildspec.yml`): its webhook builds every push to master and
  pushes `judge0:<sha>` plus `:latest`; a SHA already in ECR is never
  rebuilt; its layer cache is `judge0:buildcache`. CodeBuild is the only
  writer: the old "Trigger Production Build" GitHub workflow was retired
  because it lacked that guard. The ECR repo's
  lifecycle policy keeps the newest 50 tagged images and expires untagged
  entries after 7 days, so a deployed SHA survives about 50 later merges.
  Staging pulls Docker Hub `newtonschool/newton-judge0:<sha>`. Deploys are
  **single-image** (no docker-compose); the deployed image connects to
  managed Postgres + managed Redis from the environment.
- **AL2 → AL2023 NodeClass flip is done.** The karpenter `code-compiler`
  NodeClass moved to `amiFamily: AL2023` ahead of the 0.67 deploy, so
  `docker-entrypoint.sh`'s cgroup-v2 setup is active in prod and the
  RSS-based memory / `cpu.stat`-based time semantics work as designed.
  Future image bumps inherit this — no per-bump prerequisite.
- See `git log` for the 0.53 → 0.67 chronology if you need to bisect a regression.
