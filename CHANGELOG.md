# v1.5.0 (2020-01-01)
## New Features
- Added **30 new languages**, archived 42 languages and kept active 2 languages from the last release. In total, there are now **32 active languages** that can be used and all are updated to their latest versions as of the date of this release.  Archived languages cannot be used anymore. Following table shows a status of every language that API supports.
    - Issues: [#51](https://github.com/judge0/api/issues/51) [#90](https://github.com/judge0/api/issues/90) [#106](https://github.com/judge0/api/issues/106) [#131](https://github.com/judge0/api/issues/131)
    - Commits: [@f86a546c](https://github.com/judge0/api/commit/f86a546cb9c90eeaedf08862d2a2a2a76293a87f)

|ID|Name|Status|
|---|---|---|
|1|Bash (4.4)|archived|
|2|Bash (4.0)|archived|  
|3|Basic (fbc 1.05.0)|archived|  
|4|C (gcc 7.2.0)|archived|
|5|C (gcc 6.4.0)|archived|
|6|C (gcc 6.3.0)|archived|
|7|C (gcc 5.4.0)|archived|
|8|C (gcc 4.9.4)|archived|
|9|C (gcc 4.8.5)|archived|
|10|C++ (g++ 7.2.0)|archived|
|11|C++ (g++ 6.4.0)|archived|
|12|C++ (g++ 6.3.0)|archived|
|13|C++ (g++ 5.4.0)|archived|
|14|C++ (g++ 4.9.4)|archived|
|15|C++ (g++ 4.8.5)|archived|
|16|C# (mono 5.4.0.167)|archived|
|17|C# (mono 5.2.0.224)|archived|
|18|Clojure (1.8.0)|archived|
|19|Crystal (0.23.1)|archived|
|20|Elixir (1.5.1)|archived|
|21|Erlang (OTP 20.0)|archived|   
|22|Go (1.9)|archived|
|23|Haskell (ghc 8.2.1)|archived|
|24|Haskell (ghc 8.0.2)|archived|
|25|Insect (5.0.0)|archived|
|26|Java (OpenJDK 9 with Eclipse OpenJ9)|archived|
|27|Java (OpenJDK 8)|archived|
|28|Java (OpenJDK 7)|archived|
|29|JavaScript (nodejs 8.5.0)|archived|
|30|JavaScript (nodejs 7.10.1)|archived|
|31|OCaml (4.05.0)|archived|
|32|Octave (4.2.0)|archived|
|33|Pascal (fpc 3.0.0)|archived|
|34|Python (3.6.0)|archived|
|35|Python (3.5.3)|archived|
|36|Python (2.7.9)|archived|
|37|Python (2.6.9)|archived|
|38|Ruby (2.4.0)|archived|
|39|Ruby (2.3.3)|archived|
|40|Ruby (2.2.6)|archived|
|41|Ruby (2.1.9)|archived|
|42|Rust (1.20.0)|archived|
|43|Plain Text|Renamed from `Text (plain text)`.|
|44|Executable|Not changed.|
|45|Assembly (NASM 2.14.02)|**NEW**|
|46|Bash (5.0.0)|**NEW**|
|47|Basic (FBC 1.07.1)|**NEW**|
|48|C (GCC 7.4.0)|**NEW**|
|49|C (GCC 8.3.0)|**NEW**|
|50|C (GCC 9.2.0)|**NEW**|
|51|C# (Mono 6.6.0.161)|**NEW**|
|52|C++ (GCC 7.4.0)|**NEW**|
|53|C++ (GCC 8.3.0)|**NEW**|
|54|C++ (GCC 9.2.0)|**NEW**|
|55|Common Lisp (SBCL 2.0.0)|**NEW**|
|56|D (DMD 2.089.1)|**NEW**|
|57|Elixir (1.9.4)|**NEW**|
|58|Erlang (OTP 22.2)|**NEW**|
|59|Fortran (GFortran 9.2.0)|**NEW**|
|60|Go (1.13.5)|**NEW**|
|61|Haskell (GHC 8.8.1)|**NEW**|
|62|Java (OpenJDK 13.0.1)|**NEW**|
|63|JavaScript (Node.js 12.14.0)|**NEW**|
|64|Lua (5.3.5)|**NEW**|
|65|OCaml (4.09.0)|**NEW**|
|66|Octave (5.1.0)|**NEW**|
|67|Pascal (FPC 3.0.4)|**NEW**|
|68|PHP (7.4.1)|**NEW**|
|69|Prolog (GNU Prolog 1.4.5)|**NEW**|
|70|Python (2.7.17)|**NEW**|
|71|Python (3.8.1)|**NEW**|
|72|Ruby (2.7.0)|**NEW**|
|73|Rust (1.40.0)|**NEW**|
|74|TypeScript (3.7.4)|**NEW**|

- Added route `GET /languages/:id` for getting all attributes of specified language.
    - Commits: [@2a31e963](https://github.com/judge0/api/commit/2a31e96326651b90b59403d811ae48445fa4202e)
- Added route `GET /languages/all` for getting a list of all languages (archived and active).
    - Commits: [@2a31e963](https://github.com/judge0/api/commit/2a31e96326651b90b59403d811ae48445fa4202e)
- Added route `DELETE /submissions/:token` for deleting specified submission. Only authorized requests (users) are allowed to delete a submission.
    - Commits: [@3365e3c8](https://github.com/judge0/api/commit/3365e3c8da28bd273dbd7a21417e75fe393d83ee)
- Added configuration variable `ENABLE_SUBMISSION_DELETE` with default value set to `false`. By default you cannot delete a submission as long as this variable is set to `false`. When set to `true` then only authorized requests (users) can delete specific submission.
    - Commits: [@79e1de95](https://github.com/judge0/api/commit/79e1de95a4a6d2e022af557b96056b009a90be5e)
- Added info routes `GET /about`, `GET /version`, `GET /license` and `GET /isolate`. Last route `GET /isolate` returns result from [`isolate --version`](https://github.com/ioi/isolate) command.
    - Commits: [@9f5202a5](https://github.com/judge0/api/commit/9f5202a501f8cc2375be68908c6fbd0249ac3dd1)

## Improvements
- Updated base image to `judge0/api-base:1.0.0` which uses [Debian "buster"](https://www.debian.org/releases/buster/) and has installed Ruby 2.7.0.
    - Issues: [#113](https://github.com/judge0/api/issues/113)
    - Commits: [@f86a546c](https://github.com/judge0/api/commit/f86a546cb9c90eeaedf08862d2a2a2a76293a87f)
- Improved handling of an server error when one or more submission attributes cannot be serialized to JSON without Base64 encoding. User now gets an error with instructions to use `base64_encoded=true` query parameter.
    - Issues: [#107](https://github.com/judge0/api/issues/107) [#129](https://github.com/judge0/api/issues/129) [#130](https://github.com/judge0/api/issues/130)
    - Commits: [@cdcaa512](https://github.com/judge0/api/commit/cdcaa5122f96c90c0a9fcd16273a808c0ff06d4e)

## Bug Fixes
- Fixed example in configuration for using `ALLOW_ORIGIN` variable with multiple origins.
    - Commits: [@21d0202a](https://github.com/judge0/api/commit/21d0202ae16aa2e92853d146ba8fedb0c6bb6ab2)
- Fixed a bug where value of `MAX_MAX_PROCESSES_AND_OR_THREADS` was used as default value for `max_processes_and_or_threads` attribute of submission, whereas `MAX_PROCESSES_AND_OR_THREADS` should be used.
    - Commits: [@563f8ea2](https://github.com/judge0/api/commit/563f8ea264dad9396b4e7743cef187c785cbee67)

## Other Changes
- Increased maximum allowed `compiler_options` and `command_line_arguments` length to 512 characters.
    - Issues: [#122](https://github.com/judge0/api/issues/122)
    - Commits: [@3d4df3bf](https://github.com/judge0/api/commit/3d4df3bfe661ddff9ee7e6c015fa4403baf8be85)
- Increased default value of `MAX_PROCESSES_AND_OR_THREADS` to 60.
    - Commits: [@563f8ea2](https://github.com/judge0/api/commit/563f8ea264dad9396b4e7743cef187c785cbee67)
- Increased default value of `MAX_MAX_PROCESSES_AND_OR_THREADS` to 120.
    - Commits: [@563f8ea2](https://github.com/judge0/api/commit/563f8ea264dad9396b4e7743cef187c785cbee67)
- Changed default value of `RAILS_ENV` to `production`.
    - Commits: [@be55ca65](https://github.com/judge0/api/commit/be55ca656b524c5e99e75bd6d6207c4a078f5689)
- Changed default value of `INTERVAL` to 0.1.
    - Commits: [@be55ca65](https://github.com/judge0/api/commit/be55ca656b524c5e99e75bd6d6207c4a078f5689)
- Updated year in LICENSE.
    - Commits: [@679fb2ba](https://github.com/judge0/api/commit/679fb2bad981a22dcaebdd63baff506678b36939)
- Added environment variables `JUDGE0_{HOMEPAGE,SOURCE_CODE,MAINTAINER,VERSION}`. Isolate sandbox inherits these variables and they are now available for use in user code.
    - Commits: [@9f5202a5](https://github.com/judge0/api/commit/9f5202a501f8cc2375be68908c6fbd0249ac3dd1)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.5.0/judge0-api-v1.5.0.zip
unzip judge0-api-v1.5.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.5.0
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.5.0 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.4.0 (2019-10-31)
## New Features
- Added support for `compiler_options` and `command_line_arguments`.
- Added configuration variables `ENABLE_COMPILER_OPTIONS`, `ALLOWED_LANGUAGES_FOR_COMPILER_OPTIONS` and `ENABLE_COMMAND_LINE_ARGUMENTS` for controlling usage of compiler options and command line arguments.

## Security Improvements
- Run compilation process for compiled languages inside sandbox and use values of *limit configuration variables* for controlling sandbox resources.
- Move application location from `/usr/src/api` to `/api` to prevent untrusted code from reading it.
    - Commits: [@0f1b07fe](https://github.com/judge0/api/commit/0f1b07fe0f75141ec82431ef28ad939d73e418a3)

## Other Changes
- Don't link math library for C language by default. You now need to send `-lm` in `compiler_options`.
    - Commits: [@619a3bbe](https://github.com/judge0/api/commit/619a3bbed204b22c71e012f0de0faabf6f846d70)


## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.4.0/judge0-api-v1.4.0.zip
unzip judge0-api-v1.4.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.4.0
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.4.0 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.3.1 (2019-09-16)
## Improvements
- Improved handling exec format error by introducing new status **Exec Format Error**.
    - Commits: [@93a60115](https://github.com/judge0/api/commit/93a601159187d67d1ca52e8c06ebecd8318ed6c3)

## Bug Fixes
- Fixed bug where execution of Go code with no `main` package would induce `execve("./main"): No such file or directory` because Go compiler wouldn't create `main` binary.
    - Commits: [@93a60115](https://github.com/judge0/api/commit/93a601159187d67d1ca52e8c06ebecd8318ed6c3)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.3.1/judge0-api-v1.3.1.zip
unzip judge0-api-v1.3.1.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.3.1
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.3.1 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.3.0 (2019-09-15)
## New Features
- Added `MAX_QUEUE_SIZE` variable that defines a maximum submission queue size. If there is a new submission request and the queue is full, then that submission will be rejected.
    - Commits: [@a2bcdecb](https://github.com/judge0/api/commit/a2bcdecbb99dbd8d3875e2f95bdf71f12e34f495)

## Improvements
- Improved worker shutdown procedure. Workers are now gracefully shutdown on `docker stop`.
    - Commits: [@2ae0cd31](https://github.com/judge0/api/commit/2ae0cd31153dca4218638096d390ee6f84896236)

## Bug Fixes
- Fixed a bug where authentication token was auto converted to integer.
    - Issues: [#101](https://github.com/judge0/api/issues/101)
    - Commits: [@b92c4970](https://github.com/judge0/api/commit/b92c49705c687e955f91dc6638015f14bbcad97c)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.3.0/judge0-api-v1.3.0.zip
unzip judge0-api-v1.3.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.3.0
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.3.0 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.2.2 (2019-09-07)
## Securty Fixes
- Fixed a bug that allowed anybody to read `judge0-api.conf` file. This bug was introduced in version [v1.2.1](https://github.com/judge0/api/releases/tag/v1.2.1) when config was mounted into container. With this fix, config is still mounted into container but not in `/usr/src/api` folder but rather in `/`. Root folder is not binded in isolate sandbox, whereas `/usr/src/api` is.
  - Commits: [@121c8f9d](https://github.com/judge0/api/commit/121c8f9de8d89b45c5fec69266d625b375e3181e)

## Other Changes
- Don't allow execution of scripts in `/usr/src/api` folder.
  - Commits: [@121c8f9d](https://github.com/judge0/api/commit/121c8f9de8d89b45c5fec69266d625b375e3181e)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.2.2/judge0-api-v1.2.2.zip
unzip judge0-api-v1.2.2.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.2.2
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.2.2 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.2.1 (2019-08-24)
## Improvements
- Improved config loading. Config can now be changed and reload just with `docker-compose restart` command.
  - Commits: [@06fc37f1](https://github.com/judge0/api/commit/06fc37f16571840e87c41658807da20a08358926)

## Bug Fixes
- Fixed bug in `run-worker` script that didn't consider `COUNT` config variable.
  - Issues: [#91](https://github.com/judge0/api/issues/91)
  - Commits: [@06fc37f1](https://github.com/judge0/api/commit/06fc37f16571840e87c41658807da20a08358926)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.2.1/judge0-api-v1.2.1.zip
unzip judge0-api-v1.2.1.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.2.1
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.2.1 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.2.0-nim0.20.0 (2019-06-26)
This image contains only [The Nim Programming Language](https://nim-lang.org). Free public instance of this image is available on https://nim.api.judge0.com.

This image was build for the purpose of creating dedicated web playground for this language, and in the future I will add and deploy every new release of it. In the [`nim`](https://github.com/judge0/api-base/tree/nim) branch of Judge0 API Base I will follow and install new releases of Nim, and in the [`nim`](https://github.com/judge0/api/tree/nim) branch of Judge0 API I will maintain a Judge0 API that only has Nim available.

Free playground for the Nim programming language that uses Judge0 API is available at https://nim.ide.judge0.com.

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.2.0-nim0.20.0/judge0-api-v1.2.0-nim0.20.0.zip
unzip judge0-api-v1.2.0-nim0.20.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.2.0-nim0.20.0
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.2.0-nim0.20.0 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.2.0-vlang0.1.3 (2019-06-26)
This image contains only [The V Programming Language](https://vlang.io), specifically only V compiler built from commit [@b00a47be](https://github.com/vlang/v/commit/b00a47be66e868b087146feb7999fd72f2af3da0). Free public instance of this image is available on https://vlang.api.judge0.com.

This image was build for the purpose of creating dedicated web playground for this new programming language, and in the future I will add and deploy every new release of it. In the [`vlang`](https://github.com/judge0/api-base/tree/vlang) branch of Judge0 API Base I will follow and install new releases of V, and in the [`vlang`](https://github.com/judge0/api/tree/vlang) branch of Judge0 API I will maintain a Judge0 API that only has V available.

Free playground for the V programming language that uses Judge0 API is available at https://vlang.ide.judge0.com.

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.2.0-vlang0.1.3/judge0-api-v1.2.0-vlang0.1.3.zip
unzip judge0-api-v1.2.0-vlang0.1.3.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.2.0-vlang0.1.3
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.2.0-vlang0.1.3 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.2.0 (2019-06-17)
## New Features
- Added new language **Executable** that allows executing custom executable files.
  - Commits: [@0ab08351](https://github.com/judge0/api/commit/0ab08351f59ae75d9626b6941be3728b48e835db)
- Added new configuration variables: `REDIS_PASSWORD`, `REDIS_PORT` and `POSTGRES_PORT`.
  - Commits: [@962d7d1d](https://github.com/judge0/api/commit/962d7d1dcff051357de492f2d31e996405b1d125)

## Improvements
- Improved `run-server` and `run-worker` scripts.
  - Commits: [@e1b3564b](https://github.com/judge0/api/commit/e1b3564b5f262c610c42a45879e313eca93e720f)

## Bug Fixes
- Fixed `/etc/apt/sources.list` that prevented package update.
  - Issues: [#84](https://github.com/judge0/api/issues/84)
  - Commits: [@7fdca3cf](https://github.com/judge0/api/commit/7fdca3cfa5f3bddefbe2ae1e12a18ba18a7e5f63)
- Fixed cleanup bug that didn't remove sandbox files if `tmp` directory was not empty.
  - Commits: [@50ee4dbf](https://github.com/judge0/api/commit/50ee4dbf841bc9d0ce195380aaa1c5ee957ee2b7)
- Fixed another UTF-8 problem with Python that @nguyenvanquan7826 reported.
  - Issues: [#69](https://github.com/judge0/api/issues/69)
  - Commits: [@64635c98](https://github.com/judge0/api/commit/64635c98f7c0475e33b9b4629a6da8bc20fff60a)

## Other Changes
- Updated some gems that had security issues.
  - Pull Requests: [#77](https://github.com/judge0/api/pull/77) [#78](https://github.com/judge0/api/pull/78) [#79](https://github.com/judge0/api/pull/79) [#80](https://github.com/judge0/api/pull/80) [#81](https://github.com/judge0/api/pull/81) [#82](https://github.com/judge0/api/pull/82)
  - Commits: [@e1b3564b](https://github.com/judge0/api/commit/e1b3564b5f262c610c42a45879e313eca93e720f)
- Prepared Isolate Job for accepting custom compile flags.
  - Commits: [@4f2dde1f](https://github.com/judge0/api/commit/4f2dde1f79e32545da219de5cea7c5aaf25869cb)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.2.0/judge0-api-v1.2.0.zip
unzip judge0-api-v1.2.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.2.0
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.2.0 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.5-python3.6.8 (2019-03-08)
On @guvenim [request](https://github.com/judge0/api/issues/67) I have built an Judge0 API image that contains just Python 3.6.8. This release also shows what changes are necessary in [api-base](https://github.com/judge0/api-base/commit/bfde9426e4a3d44098dab2a2d082e02de2bc5be5) and [api](https://github.com/judge0/api/commit/9f9f5cd0577a724d66be934c11d2e57b2b3fc705) when you only want to use languages that you need.
  
## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.5-python3.6.8/judge0-api-v1.1.5-python3.6.8.zip
unzip judge0-api-v1.1.5-python3.6.8.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.5-python3.6.8
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.1.5-python3.6.8 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.5 (2019-02-17)
## Bug Fixes
- Fixed problem with assigning compile output to submission when rerunning submission.
  - Commits: [@c3cd0232](https://github.com/judge0/api/commit/c3cd023258a4ec48949d4ee2310bc39a2f40cac9)

## Other Changes
- Remove unwanted newlines from compile output.
  - Commits: [@c3cd0232](https://github.com/judge0/api/commit/c3cd023258a4ec48949d4ee2310bc39a2f40cac9)
  
## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.5/judge0-api-v1.1.5.zip
unzip judge0-api-v1.1.5.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.5
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.1.5 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.4 (2019-02-17)
## Bug Fixes
- Fixed problem with assigning compile output to submission when compile output is not empty.
  - Commits: [@22403707](https://github.com/judge0/api/commit/224037078325dfe02f5fbf191a55513582ca84b5)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.4/judge0-api-v1.1.4.zip
unzip judge0-api-v1.1.4.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.4
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.1.4 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.3 (2019-02-15)
## Improvements
- Improved cleanup of sandbox by deleting stdin, stdout, stderr and meta file before running isolate cleanup.
  - Commits: [@1dcfaf98](https://github.com/judge0/api/commit/1dcfaf98536fc55fe200c57de10540de64936654)
  
## Bug Fixes
- Fixed problem with compile output that contained invalid byte sequence in UTF-8.
  - Commits: [@37d46b14](https://github.com/judge0/api/commit/37d46b140c75aaafeca35ffc36e53746e0905387)
- Fixed problem with submissions not changing their post-run attributes after rerun if compile error occured.
  - Commits: [@37d46b14](https://github.com/judge0/api/commit/37d46b140c75aaafeca35ffc36e53746e0905387)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.3/judge0-api-v1.1.3.zip
unzip judge0-api-v1.1.3.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.3
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.1.3 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.2 (2019-02-15)
## Improvements
- Improved reading from stdin and writing to stdout, stderr and meta. They are now not available in sandbox.
  - Commits: [@1f135c1a](https://github.com/judge0/api/commit/1f135c1a53f5039b52de5e9c78764c80a7ed3945) [@350ff3a4](https://github.com/judge0/api/commit/350ff3a4705b6d83ef4f1188de52586cbb87e693)

## Bug Fixes
- Fixed writing of source code and stdin to disc, they are now written as binary files to avoid UTF-8 problems.
  - Commits: [@519efbea](https://github.com/judge0/api/commit/519efbea1548f9dab5a95032af2cfa88fc319c65)
- Fixed problem with stripping output that contained invalid byte sequence in UTF-8.
  - Commits: [@4c994c67](https://github.com/judge0/api/commit/4c994c67630d6679a636a656ba0041ba6a680219)

## Other Changes
- Use `judge0/api-base:0.3.0` as base image which uses [isolate@18554e83](https://github.com/ioi/isolate/commit/18554e83793508acd1032d0cf4229a332c43085e).
  - Commits: [@350ff3a4](https://github.com/judge0/api/commit/350ff3a4705b6d83ef4f1188de52586cbb87e693)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.2/judge0-api-v1.1.2.zip
unzip judge0-api-v1.1.2.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.2
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.1.2 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.1 (2019-02-13)
## Bug Fixes
- Fixed a problem when `strip` method was called on a `nil` class when expected output was `nil`.
  - Commits: [@b25153e9](https://github.com/judge0/api/commit/b25153e9450569c995e8f3afe036fed4ad58726c)

## Other Changes
- Don't let worker update submission's `finished_at` attribute if it already exists. This allows Judge0 API administrators to manually rerun submissions from command line and preserve initial timestamps if some unexpected error occured.
  - Commits: [@b25153e9](https://github.com/judge0/api/commit/b25153e9450569c995e8f3afe036fed4ad58726c)

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.1/judge0-api-v1.1.1.zip
unzip judge0-api-v1.1.1.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.1
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.1.1 is now available at `http://<IP OF YOUR SERVER>:3000`.


# v1.1.0 (2019-02-10)
## New Features
- Added `-lm` compile flag to link with math library when compiling C source code.
  - Pull Requests: [#60](https://github.com/judge0/api/pull/60)
- Added fixed time limit of 10 seconds for compilation.
  - Issues: [#63](https://github.com/judge0/api/issues/63) [#64](https://github.com/judge0/api/issues/64)
  - Commits: [@2f05ce2c](https://github.com/judge0/api/commit/2f05ce2c9305fccaeb0c08e23d645736593d787e)
  
## Improvements
- Improved procedure of seeding database with languages. Seeding is now idempotent.
  - Commits: [@72cff961](https://github.com/judge0/api/commit/72cff9616db20bed128a38111e3c28dbfc75696e)

## Bux Fixes
- Fixed versions of Postgres and Redis in Docker Compose files.
  - Issues: [#20](https://github.com/judge0/api/issues/20) [#38](https://github.com/judge0/api/issues/38) [#40](https://github.com/judge0/api/issues/40) [#45](https://github.com/judge0/api/issues/45) [#47](https://github.com/judge0/api/issues/47) [#56](https://github.com/judge0/api/issues/56) [#57](https://github.com/judge0/api/issues/57)
  - Commits: [@80a61629](https://github.com/judge0/api/commit/80a61629129af75e1d8a4bb167b349ab34cabfd3) [@90ec40cf](https://github.com/judge0/api/commit/90ec40cf5b4dc2ca6aa4c3af59326d431530cf80)
- Fixed problem with workers stopping when they lost connection with Postgres or Redis.
  - Commits: [@eee340b6](https://github.com/judge0/api/commit/eee340b650aeacc7971ce5e73652a7bfa9e243af)
- Fixed problem of storing submission's stdout and stderr that contained invalid byte sequence in UTF-8.
  - Commits: [@ff63c1bc](https://github.com/judge0/api/commit/ff63c1bc498a62101d4c074f5aa7b7a971550164)
  
## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.1.0/judge0-api-v1.1.0.zip
unzip judge0-api-v1.1.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.1.0
docker-compose up -d
sleep 10s
```


# v1.0.0 (2017-10-01)
This is the first production ready release of Judge0 API.

## Deployment Procedure
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/api/releases/download/v1.0.0/judge0-api-v1.0.0.zip
unzip judge0-api-v1.0.0.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-api-v1.0.0
docker-compose up -d
sleep 10s
```

4. Your instance of Judge0 API v1.0.0 is now available at `http://<IP OF YOUR SERVER>:3000`.
