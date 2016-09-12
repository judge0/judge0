# judge0-demo

judge0-demo is a static web page which is used for [www.judge0.com](http://www.judge0.com).

It can be used for development because it provides simple interface for interacting with API.

## Development

If you are using judge0-demo for development then you need to change [`BASE_URL`](https://github.com/hermanzdosilovic/judge0/blob/master/demo/js/demo.js#L1) variable in [js/demo.js](https://github.com/hermanzdosilovic/judge0/blob/master/demo/js/demo.js). Following proposed [development workflow](https://github.com/hermanzdosilovic/judge0/tree/master/api#development-workflow) it should be set to `http://localhost:3000`.

## Production

You can host your own version of this demo page if you want.

Be sure to change [`BASE_URL`](https://github.com/hermanzdosilovic/judge0/blob/master/demo/js/demo.js#L1) variable in [js/demo.js](https://github.com/hermanzdosilovic/judge0/blob/master/demo/js/demo.js). It needs to point to your production API endpoint, and you **cannot** use [api.judge0.com](http://api.judge0.com/). You can also add Google Analytics tracking code in [index.html](https://github.com/hermanzdosilovic/judge0/blob/master/demo/index.html#L137).

Because this is simple static web page you can host it in number of ways.

For example, [www.judge0.com](http://www.judge0.com) is hosted on [AWS S3](https://aws.amazon.com/s3), checkout these tutorials:
* [Hosting a Static Website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html)
* [Setting Up a Static Website Using a Custom Domain](https://docs.aws.amazon.com/AmazonS3/latest/dev/website-hosting-custom-domain-walkthrough.html)

But, of course, you can also use Docker:

1. Copy [demo](https://github.com/hermanzdosilovic/judge0/tree/master/demo) folder to your server.
2. In [nginx.conf](https://github.com/hermanzdosilovic/judge0/blob/master/demo/nginx.conf) change [`server_name`](https://github.com/hermanzdosilovic/judge0/blob/master/demo/nginx.conf#L3).
3. Build Docker image:
```
$ docker build -t <your name>/judge0-base .
```
4. Run container:
```
$ docker run -p 80:80 -d <your name>/judge0-base
```

You could also build your Docker image on your local machine, push it to Docker Hub, pull it on your server and run new container.
