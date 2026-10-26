# Experimental cgroups v2 deployment

Related to https://github.com/judge0/judge0/issues/543.

This opt-in image uses the pinned Judge0 CE 1.13.1 image as a compiler/runtime
base, installs this checkout's Ruby dependencies and application source, and
adds upstream Isolate 2.2.1 (9c84554464d2aa9161a424e70af67f4210a12c45).
The default Compose deployment
continues to use Isolate 1 and its existing timing flags. This is a candidate
implementation for review, not a security audit or a replacement stable release.

## Run

From this directory, with Docker Compose supporting `cgroup: private`, Python 3,
Linux cgroups v2 and kernel 5.19 or newer:

```sh
python3 init-config.py
ruby job-test.rb
docker compose build server
docker compose up -d db redis server
docker compose logs --tail=50 server
# Wait for Puma to listen before starting the checks.
docker compose up -d --no-deps workers
python3 smoke-test.py
python3 resource-test.py
```

Configuration is generated with mode 0600 and is never overwritten. API access
is restricted to 127.0.0.1:2358 and requires X-Auth-Token from judge0.conf.
Database and Redis ports are not published. `docker compose down` preserves
the database volume; `down -v` deletes it. Do not run alongside another service
using port 2358. This image targets linux/amd64; ARM hosts require emulation.

## Design and limitations

- Only workers are privileged. Each has its own private cgroup namespace.
  Bootstrap snapshots all process IDs before moving them to a service leaf;
  it enables controllers in the container subtree, not the host root.
- Isolate 2 measures CPU time across the cgroup. Per-process CPU timing is
  rejected, and the removed cg-timing/no-cg-timing flags are omitted.
- Isolate 2 has 1000 sandbox slots. Nonblocking file locks reserve a slot for
  the entire compile/run/cleanup cycle. More than 1000 concurrent jobs fail
  explicitly instead of reusing an active slot.
- Initialization validates both exit status and the expected sandbox path.
  Cleanup delegates deletion to Isolate rather than expanding shell globs.
- The old compiler image lacks quotactl_fd headers. A small build patch rejects
  disk-quota requests explicitly on those headers; it does not silently ignore
  them. File-size and cgroup memory limits remain available.
- Source/network callbacks and additional archives are disabled in the sample
  config. Student networking is disabled. The API tests use base64 responses
  to preserve arbitrary compiler output; UTF-8 fixes are outside this proposal.
- Only one worker container with two worker processes has been exercised.
  Hostile workloads, multi-container scaling and large classes need further
  review/testing. Resource checks are bounded functional tests, not an audit.
- Memory exhaustion may be reported as exit code 137 (NZEC) through the bash
  wrapper. The resource test checks memory usage and the kill message as well.

## Validation provenance

The precursor deployment passed 18 API checks and 3 resource checks on Docker
Desktop (ARM Mac, amd64 emulation). The operator independently reported the
same checks passing on Ubuntu 26.04, kernel 7.0.0-38, cgroups v2, Docker 29.1.3
and Compose 2.40.3. The precursor included a separate UTF-8 decoding fix.
These results do not automatically validate every change in this upstream
refactoring. See the accompanying PR description for checks rerun on this branch.
