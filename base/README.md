# judge0-base

judge0-base is simply one [Docker image](https://hub.docker.com/r/hermanzdosilovic/judge0-base/) which contains compilers, interpreters and sandbox environment.

[Isolate](https://github.com/ioi/isolate) is installed and used as sandbox environment for running untrusted programs.

Following compilers and interpreters are installed:

* gcc 4.7
* gcc 4.8
* gcc 4.9
* gcc 5.4
* g++ 4.7
* g++ 4.8
* g++ 4.9
* g++ 5.4
* Java SE 1.6
* Java SE 1.7
* Java SE 1.8
* Ruby 1.9.3
* Ruby 2.2.5
* Ruby 2.3.1
* Python 2.7.12
* Python 3.5.2

## Pulling official image

Official image can be pulled from [Docker Hub](https://hub.docker.com/):

```
$ docker pull hermanzdosilovic/judge0-base
```

## Building your own image

If you want, you can modify official [Dockerfile](https://github.com/hermanzdosilovic/judge0/blob/master/base/Dockerfile) and build your own judge0-base image which might contain different set of compilers and interpreters:

```
$ docker build -t <your name>/judge0-base .
```

If you change judge0-base image, then you will need to modify few things in [judge0-api](https://github.com/hermanzdosilovic/judge0/tree/master/api) as well.
