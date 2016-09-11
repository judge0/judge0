# judge0-demo

Demo is a static web page which is used for [www.judge0.com](http://www.judge0.com).

It can be used for development because it provides simple interface for interacting with API, but it is not necessary.

## Development

If you are using Demo for development then you need to change `BASE_URL` variable in [js/demo.js](https://github.com/hermanzdosilovic/judge0/blob/master/demo/js/demo.js#L1). Following proposed [**judge0 development workflow**](https://github.com/hermanzdosilovic/judge0/tree/master/api#development-workflow) it should be set to: `http://localhost:3000`. Now open [index.html](https://github.com/hermanzdosilovic/judge0/blob/master/demo/index.html) in your browser and use it for interacting with your development API.

## Production

You can host your own version of this demo page if you want.

Before I explain how to do that, be sure to change `BASE_URL` variable in [js/demo.js](https://github.com/hermanzdosilovic/judge0/blob/master/demo/js/demo.js#L1). It needs to point to your production API endpoint, and you **cannot** use [api.judge0.com](http://api.judge0.com/). You can also add Google Analytics tracking code in [index.html](https://github.com/hermanzdosilovic/judge0/blob/master/demo/index.html#L137).

Because this is simple static web page you can host it in number of ways. For example, [www.judge0.com](http://www.judge0.com) is hosted on [AWS S3](https://aws.amazon.com/s3), checkout these tutorials:
* [Hosting a Static Website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html)
* [Setting Up a Static Website Using a Custom Domain](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html)

But, of course, you can also use Docker:

1. Copy [demo](https://github.com/hermanzdosilovic/judge0/tree/master/demo) folder to your server.
2. In [nginx.conf](https://github.com/hermanzdosilovic/judge0/blob/master/demo/nginx.conf#L3) change `server_name` to suit your needs.
3. Build docker image:
```
$ docker build -t <yourusername>/judge0-base .
```
4. Run container:
```
$ docker run -p 80:80 -d <yourusername>/judge0-base
```

You could also build your docker image on your local machine, push it to Docker Hub, pull it on your server and run new container. But I am sure you already know how to do that if you are familiar with Docker.
