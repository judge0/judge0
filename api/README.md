# judge0-api

API is core logic of judge0. It is responsible for handling requests, creating background jobs and running untrusted code in sandboxed environment - [isolate](https://github.com/ioi/isolate). API documentation is available at [api.judge0.com](http;//api.judge0.com).

## Content

1. [Development Workflow](#development-workflow)
  * read about development workflow if you want to develop judge0
2. [How it works](#how-it-works)
  * read about how does API work if you want do develop judge0
3. [Production](#production)
  * read about how to host your own judge0

## Development Workflow

This is the most important part of judge0, because it enables you to quickly setup your development environment either on Windows or Unix. This is achieved using [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/). So before you continue reading about development workflow, please install those on your computer.

I will first explain you how to setup your development environment and then we will cover details:

1. Pull [hermanzdosilovic/judge0-base](https://hub.docker.com/r/hermanzdosilovic/judge0-base/):
    ```
    $ docker pull hermanzdosilovic/judge0-base
    ```

2. Open [docker-compose.dev.yml](https://github.com/hermanzdosilovic/judge0/blob/master/api/docker-compose.dev.yml#L8-L9) and change lines 8 and 9.
  * You can get your username with `echo $USER`, and user id with `echo $UID`

3. Run development shell (it will take a while only first time):
    ```
    $ ./dev-shell
    ```


## How it works

### Basic

The best way to explan how API behaves is using one type of _behavioral diagram_ called [sequence diagram](https://en.wikipedia.org/wiki/Sequence_diagram).

Sequence diagram consists of five actors:

* **User** - creates new Submissions or requests status of some Submission
* **Rails backend** - handles User's requests and creates new background jobs for [Resque](https://github.com/resque/resque) worker
* **Worker** - runs untrusted code in sandboxed environment and determines status/result of Submission
* **Redis** - holds information about which jobs need to be run by Worker
* **PostgreSQL** - database for storing ActiveRecord models

For more clarification please see following sequence diagram:

![UML Sequence Diagram](https://raw.githubusercontent.com/hermanzdosilovic/judge0/master/api/sequence-diagram.png)

So basically, Rails backend and Worker are independent processes that share Redis and PostgreSQL databases. Every time users [creates](http://api.judge0.com/#submissions-submission-post) new submission, Rails backend creates new job for Worker. Redis acts as a job queue from which Worker reads what is it's next job to do.

### Detailed

Please read [basic](#basic) explanation before continuing with detailed one.

Rails backend is really simple and I won't cover it in the details, I will just point you to the main controller [submissions_controller.rb](https://github.com/hermanzdosilovic/judge0/blob/master/api/app/controllers/submissions_controller.rb). Worker, on the other hand, is more interesting. So, Worker has on job called [IsolateJob](https://github.com/hermanzdosilovic/judge0/blob/master/api/app/jobs/isolate_job.rb) which got the name after sandbox environment [isolate](https://github.com/ioi/isolate) that is installed in [hermanzdosilovic/judge0-base](https://hub.docker.com/r/hermanzdosilovic/judge0-api/) Docker image.

This job is essentially very simple. It consists of [6 steps](https://github.com/hermanzdosilovic/judge0/blob/master/api/app/jobs/isolate_job.rb#L24-L28):

1. Initialize sandbox environment
2. Write source code and input to file
3. Compile if needed
4. Run if compile was successful
5. Determine status of Submission based on isolate metadata.
6. Clean sandbox environment
