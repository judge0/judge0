# [NEWS] Please read [this](https://judge0.com/announcement-of-judge0-api-2-0-0/) blog post (1 min read) before continuing. 

# Judge0 API
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/judge0/api/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/hermanzdosilovic)

## About
**Judge0 API** is an web API for code compilation and execution. Complete and detailed API documentation is available
on https://api.judge0.com.

## Content
1. [Supported Languages](#supported-languages)
2. [Project Organization](#project-organization)
3. [Quick Development Setup](#quick-development-setup)
4. [Quick Production Setup](#quick-production-setup)
5. [About Docker Images](#about-docker-images)
6. [Adding New Compiler or Interpreter](#adding-new-compiler-or-interpreter)
7. [HTTPS In Production](#https-in-production)
8. [Notes](#notes)

## Supported Languages
|#|Name|
|:---:|:---:|
|1 |Bash (4.4)|
|2 |Bash (4.0)|
|3 |Basic (fbc 1.05.0)|
|4 |C (gcc 7.2.0)|
|5 |C (gcc 6.4.0)|
|6 |C (gcc 6.3.0)|
|7 |C (gcc 5.4.0)|
|8 |C (gcc 4.9.4)|
|9 |C (gcc 4.8.5)|
|10|C++ (g++ 7.2.0)|
|11|C++ (g++ 6.4.0)|
|12|C++ (g++ 6.3.0)|
|13|C++ (g++ 5.4.0)|
|14|C++ (g++ 4.9.4)|
|15|C++ (g++ 4.8.5)|
|16|C# (mono 5.4.0.167)|
|17|C# (mono 5.2.0.224)|
|18|Clojure (1.8.0)|
|19|Crystal (0.23.1)|
|20|Elixir (1.5.1)|
|21|Erlang (OTP 20.0)|
|22|Go (1.9)|
|23|Haskell (ghc 8.2.1)|
|24|Haskell (ghc 8.0.2)|
|25|Insect (5.0.0)|
|26|Java (OpenJDK 9 with Eclipse OpenJ9)|
|27|Java (OpenJDK 8)|
|28|Java (OpenJDK 7)|
|29|JavaScript (nodejs 8.5.0)|
|30|JavaScript (nodejs 7.10.1)|
|31|OCaml (4.05.0)|
|32|Octave (4.2.0)|
|33|Pascal (fpc 3.0.0)|
|34|Python (3.6.0)|
|35|Python (3.5.3)|
|36|Python (2.7.9)|
|37|Python (2.6.9)|
|38|Ruby (2.4.0)|
|39|Ruby (2.3.3)|
|40|Ruby (2.2.6)|
|41|Ruby (2.1.9)|
|42|Rust (1.20.0)|
|43|Text (plain text)|

## Project Organization
Judge0 API is a [Rails 5](http://weblog.rubyonrails.org/2016/6/30/Rails-5-0-final/) application organized in two major components:

* [Rails API](https://github.com/rails-api/rails-api)
  * accepts requests and creates background jobs for Worker.
* [Worker](https://github.com/resque/resque)
  * accepts new jobs and process them as they arrive. Worker has only one job - [IsolateJob](https://github.com/judge0/api/blob/master/app/jobs/isolate_job.rb), that job runs untrusted programs in sandboxed environment.

## Quick Development Setup
Setting up your development environment is easy thanks to [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/). So please install those before continuing.

Because we are running our development environment in Docker you don't need to have Ruby, Rails, PostgreSQL, Redis, etc. installed on your computer. You just need to:
1. Pull [judge0/api](https://hub.docker.com/r/judge0/api/) image:
    ```
    $ docker pull judge0/api
    ```
2. Copy `judge0-api.conf.default` to `judge0-api.conf`.
3. Run development shell (it will take a while only first time):
    ```
    $ ./scripts/dev-shell
    ```
4. Create, migrate and seed the database:
    ```
    $ rails db:setup
    ```

`scripts/dev-shell` script will open you new **development shell** always in the same container, and if container doesn't exist it will create one for you.

You need to run Rails API and Worker in order to have Judge0 API fully operational:

1. Open new development shell and in there run Rails API server:
    ```
    $ ./scripts/dev-run-server
    ```
2. Open new development shell again and in there run Worker process:
    ```
    $ ./scripts/dev-run-worker
    ```
3. Open http://localhost:3000 in your browser.

This is minimal setup for development environment, now you can open your favorite editor in your host and start developing Judge0 API.

## Quick Production Setup
To host your own Judge0 API you need to install [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) on your server and after you are done proceed with the following:

1. Copy [docker-compose.prod.yml](https://github.com/judge0/api/blob/master/docker-compose.prod.yml) on your server and save it as `docker-compose.yml`
    ```
    $ wget https://raw.githubusercontent.com/judge0/api/master/docker-compose.prod.yml -O docker-compose.yml
    ```

2. Save [judge0-api.conf.default](https://github.com/judge0/api/blob/master/judge0-api.conf.default) to your server as `judge0-api.conf`
    ```
    $ wget https://raw.githubusercontent.com/judge0/api/master/judge0-api.conf.default -O judge0-api.conf
    ```
3. In `judge0-api.conf` change `RAILS_ENV` to `production`.
4. Run database:
    ```
    $ docker-compose up -d db
    ```

5. Run all other services:
    ```
    $ docker-compose up -d
    ```

6. Open `http://<IP OF YOUR SERVER>:3000` in your browser.

## About Docker Images
This project has two Dockerfiles:
1. [Dockerfile](https://github.com/judge0/api/blob/master/Dockerfile)
   * builds `judge0/api:latest` image

2. [Dockerfile.dev](https://github.com/judge0/api/blob/master/Dockerfile.dev)
   * build `judge0/api:dev` image

`judge0/api:latest` is built FROM `judge0/api-base:latest` image which contains installed compilers and sandbox environment. This image represents production image of Judge0 API.

`judge0/api:dev` is your local development image built FROM `judge0/api:latest`. It is not pushed to Docker Hub. That is why you first need to pull `judge0/api:latest` before building your development environment.

## Adding New Compiler or Interpreter
To add new compiler or interpreter you first need to install it into Judge0 API Base image. Instructions on how to do that can be found in documentation for [Judge0 API Base](https://github.com/judge0/api-base).

After you have added your favorite compiler/interpreter to Judge0 API Base image you need to define how this compiler/interpreter is used. This is done in [`db/seeds.rb`](https://github.com/judge0/api/blob/master/db/seeds.rb) file.

You have four attributes:
* `name` - name of your language you are supporting, include also compiler name and version
* `source_file` - in what file should user's source code be saved before it is compiled
* `compile_cmd` - how this file is compiled, interpreted languages won't have this attribute
* `run_cmd` - how should we run this compiled or interpreted language

We already provided enough examples for most common languages, be sure to check that out.

## HTTPS In Production
To use HTTPS in production we are going to use https://letsencrypt.org/.

You need to have your own domain for this to work. Just use [docker-compose.prod.https.yml](https://github.com/judge0/api/blob/master/docker-compose.prod.yml) insted of [docker-compose.prod.yml](https://github.com/judge0/api/blob/master/docker-compose.prod.yml) and change `VIRTUAL_HOST`, `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL` variables.

Everything else you need to do is described in [Quick Production Setup](#quick-production-setup) section.

## Notes
Judge0 API is simple to use and develop only if you are comfortable with using Docker and Docker Compose.

Docker and Docker Compose allow us to get rid of all dependencies, and concentrate on what is important - features, functionality and reliability.

Please before working with Judge0 API project, make yourself comfortable with Docker and Docker Compose, because we are using it extensively.

We will add extensive documentation in the future about how and why we are using Docker and Docker Compose here, but this documentation won't substitute your knowledge of this technologies.

Feel free to ask us any questions in [Issues](https://github.com/judge0/api/issues) directly. :)

## Donate
If you like Judge0, please consider making a [donation](https://www.paypal.me/hermanzdosilovic) to support this project.
