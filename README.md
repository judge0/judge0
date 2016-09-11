# judge0

Judge0 is an open source online judge API for code compilation and execution on given test data. It provides extensive documentation for developing, configuring and hosting your own instance with ease. Currently supports 16 compilers and interpreters, and more of them can be added easly. It's powered by [Rails](http://rubyonrails.org/), you can use [Docker](https://www.docker.com/) in both development and production environment, and every untrusted code you run is sandboxed using [isolate](https://github.com/ioi/isolate).

## Content

This project is designed to be easy to use in both development and production environment. That is achieved using [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/). So you will need to install them on machines you wish to develop or host judge0.

I will explain in detail how you can develop, configure and host your own instance of judge0.

Please proceed with reading following content:

1. [Project Organization](#project-organization)
  * how this project is organized and what each component means in a _big picture_

## Project Organization

Judge0 project is organized in three major components:

* [Base](https://github.com/hermanzdosilovic/judge0/tree/master/base)
* [API](https://github.com/hermanzdosilovic/judge0/tree/master/api)
* [Demo](https://github.com/hermanzdosilovic/judge0/tree/master/demo)

As I already said, judge0 is _Docker driven_ in both development and production. With that in mind, Base represents base Docker image on which API will be build. It installs different compilers, interpreters and sandbox environment which are necessary for the API.

API is, however, extension of Base environment. There lays core logic of judge0 which accepts requests, creates jobs and executes untrusted programs.

Demo represents static demo webpage located at [www.judge0.com](http://www.judge0.com). It is irellevant if you want to host your own judge0, but it is useful when developing judge0 because it provides simple interface for running untrusted code. To be clear it is not necessary for judge0 development.
