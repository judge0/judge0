# judge0
[![Code Climate](https://codeclimate.com/github/hermanzdosilovic/judge0/badges/gpa.svg)](https://codeclimate.com/github/hermanzdosilovic/judge0) [![Test Coverage](https://codeclimate.com/github/hermanzdosilovic/judge0/badges/coverage.svg)](https://codeclimate.com/github/hermanzdosilovic/judge0/coverage) [![Build Status](https://travis-ci.org/hermanzdosilovic/judge0.svg?branch=master)](https://travis-ci.org/hermanzdosilovic/judge0) [![Hex.pm](https://img.shields.io/hexpm/l/plug.svg?maxAge=2592000)](https://github.com/hermanzdosilovic/judge0/blob/master/LICENSE)

Judge0 is an open source online judge API for code compilation and execution on given test data. It provides extensive documentation for developing, configuring and hosting your own instance with ease. Currently supports 16 compilers and interpreters, and more of them can be added easly. It's powered by [Rails](http://rubyonrails.org/), you can use [Docker](https://www.docker.com/) in both development and production environment, and every untrusted code you run is sandboxed using [isolate](https://github.com/ioi/isolate).

## Content

1. [Project Organization](#project-organization)
2. [Project Goals](#project-goals)
3. [Future Plans](#future-plans)
3. [Host Your judge0](#host-your-judge0)
4. [Contributing](#contributing)

## Project Organization

Project is organized in three major components:

* [judge0-base](https://github.com/hermanzdosilovic/judge0/tree/master/base)
* [judge0-api](https://github.com/hermanzdosilovic/judge0/tree/master/api)
* [judge0-demo](https://github.com/hermanzdosilovic/judge0/tree/master/demo)

[judge0-base](https://github.com/hermanzdosilovic/judge0/tree/master/base) represents base Docker image on which judge0-api will be build. It installs different compilers, interpreters and sandbox environment which are necessary for judge0-api.

[judge0-api](https://github.com/hermanzdosilovic/judge0/tree/master/api) is core logic of judge0 which accepts requests, creates background jobs and runs untrusted programs in sandboxed environment.

[judge0-demo](https://github.com/hermanzdosilovic/judge0/tree/master/demo) represents static demo web page located at [www.judge0.com](http://www.judge0.com). It is irrelevant if you want to host your own judge0, but it is useful when developing judge0 because it provides simple interface for running untrusted code.

## Project Goals

My goal is to create configurable, robust, easy to use and fully documented online judge API service which can be used and hosted by anyone for free, and I was motivated to start this project when I saw [Sphere Engine](https://sphere-engine.com).

In the future I would like to build full online judge service which will enable anybody to host their own competition, or it can be used by schools and universities for educational purposes, e.q. writing exams or solving programming exercises.

## Host Your judge0

Hosting your judge0 is easy thanks to [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/). Minimal setup for hosting your judge0 is described here [here](https://github.com/hermanzdosilovic/judge0/tree/master/api#production)

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
