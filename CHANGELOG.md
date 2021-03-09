This is the Changelog for Judge0 Extra CE. The Changelog for Judge0 CE can be found [here](https://github.com/judge0/judge0/blob/master/CHANGELOG.md). Learn more about their difference [here](https://github.com/judge0/judge0#flavors).

# v1.12.0-extra (2020-10-18)
## New Features
- Added support for invalidating statistics cache using the `invalidate_cache` query parameter.
    - Commits: [@561c2a30](https://github.com/judge0/judge0/commit/561c2a309d98680801628fc2d79ea17e885e1d66)
- Added rake task `judge0:run_in_queue` to manually run submissions that might have stuck in the `In Queue` state.
    - Commits: [@c3b87d23](https://github.com/judge0/judge0/commit/c3b87d232a8e922b5ae04f5afdb12fc49b2ec003)
- Added support for specifying `CALLBACKS_MAX_TRIES` and `CALLBACKS_TIMEOUT`. This is a global configuration that applies to all submissions that have defined webhooks (HTTP callbacks).
    - Commits: [@c4bb76ec](https://github.com/judge0/judge0/commit/c4bb76ec866bce6b07bd733391291e720f40ef96)
- Added support for submission caching to reduce the number of unnecessary database hits. Cache duration can be controlled with the `SUBMISSION_CACHE_DURATION` variable which is currently set to 1 second by default. Submissions are only cached for `GET /submissions/<token>` route. Cache files are written to the server's file system and are automatically cleared every day at midnight. This is the first step toward more serious submission caching in the future.
    - Commits: [@7a33c61c](https://github.com/judge0/judge0/commit/7a33c61c8dcbcdbf31fd4d93ef76cc2f1f5e154b) [@0b344920](https://github.com/judge0/judge0/commit/0b344920bd70bd2bf4b2a53fc78b6b145c298cbc)

## Improvements
- Update PostgreSQL to 13.0 and Redis to 6.0.
    - Commits: [@05330f11](https://github.com/judge0/judge0/commit/05330f112b26850a18c59a380991f8b401eae224) [@be300efa](https://github.com/judge0/judge0/commit/be300efa4bec7653303bb76681f91588550c25ef)
- Reschedule failed jobs after 0.1 seconds with 100 attempts.
    - Commits: [@f7265cf8](https://github.com/judge0/judge0/commit/f7265cf8d53ef5319a9e96e1bf7bee8649b09762) [@e003c888](https://github.com/judge0/judge0/commit/e003c888e64ea4f4a83e1acce8d355b666276aa2)
- Send only submission ID to the worker and not the whole serialized submission.
    - Commits: [@f7265cf8](https://github.com/judge0/judge0/commit/f7265cf8d53ef5319a9e96e1bf7bee8649b09762) [@4222c090](https://github.com/judge0/judge0/commit/4222c090689deb1a356cf6c2588b81b9904124f1)
- Automatically restart Judge0 server without the need for Docker restart policies. Use the `RESTART_MAX_TRIES` variable to specify the maximum number of restart tries.
    - Commits: [@65756516](https://github.com/judge0/judge0/commit/65756516b331265ec5a6742372ecc57ecbb8ca71) [@c0fd97e2](https://github.com/judge0/judge0/commit/c0fd97e2359172f7fc8bf7195089ab7c19845728)

## Bug Fixes
- Fixed a bug in the `is_project` method of submission model where an exception was raised and not handled properly due to unknown language.
    - Commits: [@6426ac61](https://github.com/judge0/judge0/commit/6426ac61ea6723fcf6b93b72024ec39e3dc4b7f2)

## Other Changes
- Use Docker volumes for storing Postgres and Redis data instead of mounting directories. This is now the new recommended setting.
    - Commits: [@600f5aaa](https://github.com/judge0/judge0/commit/600f5aaa3facfef38dd2cd5df25ac248734ace97)
- Added Resque Web to the development stack.
    - Commits: [@3762a635](https://github.com/judge0/judge0/commit/3762a6355b8911d8d8e13d91869edeef9bec0a4f)
- Changed binding ports for Nginx and documentation server in the development stack. Nginx is now bound to port 80, and the development server to port 3001.
    - Commits: [@3762a635](https://github.com/judge0/judge0/commit/3762a6355b8911d8d8e13d91869edeef9bec0a4f)
- Removed port bindings of Postgres and Redis in the development stack.
    - Commits: [@3762a635](https://github.com/judge0/judge0/commit/3762a6355b8911d8d8e13d91869edeef9bec0a4f)
- Added PgBouncer to the development stack for testing and experimenting.
    - Commits: [@24b3227a](https://github.com/judge0/judge0/commit/24b3227a0a47dcca89041e1c08106d08a413dcf3)
- Changed recommended values for `POSTGRES_DB` and `POSTGRES_USER`. Both are now `judge0`.
    - Commits: [@745f4455](https://github.com/judge0/judge0/commit/745f4455937d15f2f6093539e9ab96c40bc506da)

## Deployment Procedure
Judge0 is collecting telemetry data to help understand how to improve the product and to better understand how Judge0 is used in various production environments. Read more about telemetry [here](https://github.com/judge0/judge0/blob/v1.12.0-extra/TELEMETRY.md).

Please note that Judge0 has only been tested on **Linux** and **macOS**, and might not work on Windows, thus we do not provide support for it.

### With HTTP
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/judge0/releases/download/v1.12.0-extra/judge0-v1.12.0-extra.zip
unzip judge0-v1.12.0-extra.zip
```

3. Run all services and wait a few seconds until everything is initialized:
```
cd judge0-v1.12.0-extra
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

4. Your instance of Judge0 v1.12.0-extra is now available at `http://<IP ADDRESS OF YOUR SERVER>`.

### With HTTPS (SSL/TLS)
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/judge0/releases/download/v1.12.0-extra/judge0-v1.12.0-extra-https.zip
unzip judge0-v1.12.0-extra-https.zip
```

3. Change directory to `judge0-v1.12.0-extra-https`:
```
cd judge0-v1.12.0-extra-https
```
4. Edit `docker-compose.yml` and change variables `VIRTUAL_HOST`, `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL`.
5. Run all services and wait a few seconds until everything is initialized:
```
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

6. Your instance of Judge0 v1.12.0-extra is now available at `https://<YOUR DOMAIN>`.


# v1.11.0-extra (2020-09-09)
Huge thanks to [AlgoDaily](https://algodaily.com) for sponsoring this release.

## New Features
- Added **8 new languages**, and in total there are now **21 active languages**.

|ID|Name|Note|
|---|---|---|
|13|C (Clang 9.0.1)||
|14|C++ (Clang 9.0.1)||
|15|C++ Test (Clang 10.0.1, Google Test 1.8.1)||
|16|C# (.NET Core SDK 3.1.302)|Sponsored by [AlgoDaily](https://algodaily.com).|
|17|C# (Mono 6.10.0.104)|Sponsored by [AlgoDaily](https://algodaily.com).|
|18|C# Test (.NET Core SDK 3.1.302, NUnit 3.12.0)|Sponsored by [AlgoDaily](https://algodaily.com).|
|19|F# (.NET Core SDK 3.1.302)||
|20|Visual Basic.Net (vbnc 0.0.0.5943)||

- Added queue size into response of `/workers`.
    - Issues: [#210](https://github.com/judge0/judge0/issues/210)
    - Commits: [@7ee1b10c](https://github.com/judge0/judge0/commit/7ee1b10c79576e745140f02d49446d57a208bcca)

## Improvements
- Set configuration defaults even if `judge0.conf` is not present. Thank you @vvalchev.
    - Issues: [#206](https://github.com/judge0/judge0/issues/206)
    - Commits: [@8c42f7be](https://github.com/judge0/judge0/commit/8c42f7befcdf8d70fa8cb4e3ba549c828c38164d)

## Other Changes
- Updated documentation with some better explanation on the use of `base64_encoded` query parameter. Thank you @mejibyte.
- Increased default `CPU_TIME_LIMIT` to 15 s, `MAX_CPU_TIME_LIMIT` to 20 s, `WALL_TIME_LIMIT` to 20 s and `MAX_WALL_TIME_LIMIT` to 25 s.
- Increased default `MAX_MAX_FILE_SIZE` to 20480 KB.
- Increased default `MAX_PROCESSES_AND_OR_THREADS` to 100.
- Mount additional folders `/files` and `/NuGet/packages` in compilation step.

## Deployment Procedure
Judge0 is collecting telemetry data to help understand how to improve the product and to better understand how Judge0 is used in various production environments. Read more about telemetry [here](https://github.com/judge0/judge0/blob/v1.11.0-extra/TELEMETRY.md).

Please note that Judge0 has only been tested on **Linux** and might not work on Windows or macOS, thus we do not provide support for these systems.

### With HTTP
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/judge0/releases/download/v1.11.0-extra/judge0-v1.11.0-extra.zip
unzip judge0-v1.11.0-extra.zip
```

3. Run all services and wait few seconds until everything is initialized:
```
cd judge0-v1.11.0-extra
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

4. Your instance of Judge0 v1.11.0-extra is now available at `http://<IP ADDRESS OF YOUR SERVER>`.

### With HTTPS (SSL/TLS)
1. Install [Docker](https://docs.docker.com) and [Docker Compose](https://docs.docker.com/compose).
2. Download and extract release archive:
```
wget https://github.com/judge0/judge0/releases/download/v1.11.0-extra/judge0-v1.11.0-extra-https.zip
unzip judge0-v1.11.0-extra-https.zip
```

3. Change directory to `judge0-v1.11.0-extra-https`:
```
cd judge0-v1.11.0-extra-https
```
4. Edit `docker-compose.yml` and change variables `VIRTUAL_HOST`, `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL`.
5. Run all services and wait few seconds until everything is initialized:
```
docker-compose up -d db redis
sleep 10s
docker-compose up -d
sleep 5s
```

6. Your instance of Judge0 v1.11.0-extra is now available at `https://<YOUR DOMAIN>`.