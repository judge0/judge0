This is the Changelog for **Extra Edition** of Judge0. The Changelog for Standard Edition can be found [here](https://github.com/judge0/judge0/blob/master/CHANGELOG.md). Learn more about their difference [here](https://github.com/judge0/judge0#editions).

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
Judge0 is collecting telemetry data to help understand how to improve the product and to better understand how Judge0 is used in various production environments. Read more about telemetry [here](https://github.com/judge0/judge0/blob/v1.11.0/TELEMETRY.md).

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