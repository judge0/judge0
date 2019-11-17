# Judge0 API
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/judge0/api/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/hermanzdosilovic)

## About
**Judge0 API** is an web API for code compilation and execution. Complete and detailed API documentation is available
on https://api.judge0.com.

## Content
1. [Supported Languages](#supported-languages)
2. [Project Organization](#project-organization)
3. [Production Setup](#production-setup)
4. [Development Setup](#development-setup)
5. [Who Uses Judge0 API?](#who-uses-judge0-api)
5. [About Docker Images](#about-docker-images)
6. [Adding New Compiler or Interpreter](#adding-new-compiler-or-interpreter)

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
|44|Executable|

## Project Organization
Judge0 API is a [Rails 5](http://weblog.rubyonrails.org/2016/6/30/Rails-5-0-final/) application organized in two major components:

* [Rails API](https://github.com/rails-api/rails-api)
  * accepts requests and creates background jobs for Worker.
* [Worker](https://github.com/resque/resque)
  * accepts new jobs and process them as they arrive. Worker has only one job - [IsolateJob](https://github.com/judge0/api/blob/master/app/jobs/isolate_job.rb), that job runs untrusted programs in sandboxed environment.

## Production Setup
Every [release](https://github.com/judge0/api/releases) has it's own deployment procedure that you can follow.

## Development Setup
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

`scripts/dev-shell` script will open you new **development shell** always in the same container, and if container doesn't exist it will create one for you.

You need to run Rails API and Worker in order to have Judge0 API fully operational:

1. Open new development shell and in there run Rails API server:
    ```
    $ ./scripts/run-server
    ```
2. Open new development shell again and in there run Worker process:
    ```
    $ ./scripts/run-workers
    ```
3. Open http://localhost:3000 in your browser.

This is minimal setup for development environment, now you can open your favorite editor in your host and start developing Judge0 API.

## Who Uses Judge0 API?
Following projects and organizations successfully use Judge0 API in production:
- [University of Zagreb, Faculty of Electrical Engineering and Computing](https://www.fer.unizg.hr/en)
- [KPR Institute of Engineering and Technology](https://www.kpriet.ac.in)
- [Institute of Aeronautical Engineering](https://www.iare.ac.in)
- [Newton School](https://www.newtonschool.co)
- [Dilla University](http://www.duvlab.website)
- [Techie Delight](https://techiedelight.com)
- [CodeForum.ORG](https://codeforum.org)
- [primat.org](http://primat.org)
- [Codify](https://codify.herokuapp.com)
- [GeekCoders](http://www.geekcoders.co.in)
- [Judge Code Online](http://en.chamcode.net)
- [Studyfied](https://studyfied.com)
- [ThinkingBell](https://www.thinkingbell.com)
- [Xiith](https://xiith.com)
- [judge0api](https://github.com/vCra/judge0api)
- [nGrader](https://ngrader.herokuapp.com)
- [wkspace](http://wkspace.herokuapp.com)
- [CodeRunner](https://github.com/codeclassroom/CodeRunner)

Do you use Judge0 API? If so, please let me know so I can add you to the list!

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

## Donate
If you like Judge0, please consider making a [donation](https://www.paypal.me/hermanzdosilovic) to support this project.
