# judge0-api

judge0-api is core logic of judge0 which accepts requests, creates background jobs and runs untrusted programs in sandboxed environment.

## Content

1. [Project Organization](#project-organization)
2. [Development](#development)
3. [Production](#production)

## Project Organization

judge0-api is [Rails 5](http://weblog.rubyonrails.org/2016/6/30/Rails-5-0-final/) application organized in two major components:

* [Rails API](https://github.com/rails-api/rails-api)
* [Worker](https://github.com/resque/resque)

Rails API accepts requests and creates background jobs for Worker. API documentation is available on [api.judge0.com](https://api.judge0.com)

Worker accepts new jobs and process them as they arrive. Worker has only one job - [IsolateJob](https://github.com/hermanzdosilovic/judge0/blob/master/api/app/jobs/isolate_job.rb), that job runs untrusted programs in sandboxed environment.

## Development

Setting up your development environment is easy thanks to [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/). So please install those before continuing.

Because we are running our development environent in Docker you don't need to have Ruby, Rails, PostgreSQL, Redis, etc. installed on your computer. You just need to:

1. Pull [hermanzdosilovic/judge0-base](https://hub.docker.com/r/hermanzdosilovic/judge0-base/):
    ```
    $ docker pull hermanzdosilovic/judge0-base
    ```

2. Run development shell (it will take a while only first time):
    ```
    $ ./dev-shell
    ```
3. Create, migrate and seed the database:
    ```
    $ rails db:create db:migrate db:seed
    ```

`dev-shell` script will open you new **development shell** always in the same container, and if container doesn't exist it will create one for you.

You need to run Rails API and Worker in order to have judge0-api fully operational:

1. Open new development shell and in there run Rails API server:
    ```
    $ rails s -b 0.0.0.0
    ```

2. Open new development shell again and in there run Worker process:
    ```
    $ rails resque:work QUEUE=*
    ```

This is minimal setup for development environment, now you can open your favorite editor in your host and start developing judge0.

## Production

To host your own judge0 you need to install [Docker](https://docs.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) on your server and after you are done proceed with the following:

1. Copy [docker-compose.prod.yml](https://github.com/hermanzdosilovic/judge0/blob/master/api/docker-compose.prod.yml) on your server and save it as `docker-compose.yml`
    ```
    $ wget https://raw.githubusercontent.com/hermanzdosilovic/judge0/master/api/docker-compose.prod.yml -O docker-compose.yml
    ```

2. Copy [judge0-api.conf](https://github.com/hermanzdosilovic/judge0/blob/master/api/judge0-api.conf) to your server
    ```
    $ wget https://raw.githubusercontent.com/hermanzdosilovic/judge0/master/api/judge0-api.conf 
    ```

3. In `judge0-api.conf` change following variables: `RAILS_ENV` and `ALLOW_ORIGIN`.
4. In `docker-compose.yml` change following variables: `VIRTUAL_HOST`, `LETSENCRYPT_HOST` and `LETSENCRYPT_EMAIL`.
5. Run database:
    ```
    $ docker-compose up -d db
    ```

6. Run all other services:
    ```
    $ docker-compose up -d
    ```
