FORMAT: 1A
HOST: https://api.judge0.com

# Judge0 API
<!-- include(hostname.html) -->
<!-- include(style.html) -->

## About
[Judge0](https://judge0.com) is a **non-profit organization** that creates free and [open-source](https://github.com/judge0) tools and services for executing and grading untrusted source code.

[Judge0 API](https://api.judge0.com) is a free, robust, and scalable [open-source](https://github.com/judge0/api) online code execution system. It can be used to build a wide range of applications varying from competitive programming platforms, educational and recruitment platforms, to online code editors, and more.

To see Judge0 API in action, try [Judge0 IDE](https://ide.judge0.com) - a free and [open-source](https://github.com/judge0/ide) online code editor that uses Judge0 API for executing the user’s source code. You can also try using a [dummy client](/dummy-client.html) which can help you explore and test most of the features of the Judge0 API.

## Official public API
Official public API is freely available at [https://api.judge0.com](https://api.judge0.com) and is maintained by Judge0 [creator](https://github.com/hermanzdosilovic).

Status page of all public Judge0 services is available at [https://status.judge0.com](https://status.judge0.com).

::: note
<h4>Note</h4>
* You **do not** need an [authentication token](#authentication) (a.k.a. API key) for the official public API.
* You **do not** need an [authorization token](#authorization) for the official public API.
* Official public API will always be at the latest available version.
:::

::: warning
<h4>Warning</h4>
We **do not** guarantee 100% uptime of the official public API.

Since the official public API is freely available, it is used by many users simultaneously, and it should only be used for small projects and testing purposes. Thus, it **is not** intended for use in a production environment.

For the production use, consider [deploying your own instance](https://github.com/judge0/api#installation) of the Judge0 API.
:::

## Version
This document describes Judge0 API version [`v1.5.0`](https://github.com/judge0/api/tree/v1.5.0).

## Date and time formats
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

## License
Judge0 API is licensed under the [GNU General Public License v3.0](https://github.com/judge0/api/blob/master/LICENSE).

## Donate
Your are more than welcome to support Judge0 on [Patreon](https://www.patreon.com/hermanzdosilovic), via [PayPal](https://paypal.me/hermanzdosilovic) or [Revolut](https://pay.revolut.com/profile/hermancy5). Your monthly or one-time donation will help cover server costs and will support development and maintenance. Thank you! ♥

<br>

<!-- include(authentication/authentication.md) -->
<!-- include(authorization/authorization.md) -->
<!-- include(submissions/submissions.md) -->
<!-- include(statuses_and_languages/statuses_and_languages.md) -->
<!-- include(system_and_configuration/system_and_configuration.md) -->
<!-- include(health_check/health_check.md) -->
<!-- include(information/information.md) -->
