FORMAT: 1A
HOST: https://api.judge0.com

# Judge0 API docs
<!-- include(hostname.html) -->
<!-- include(style.html) -->

## About
[Judge0](https://judge0.com) is a non-profit organization that creates free and open-source tools and services for executing and grading untrusted source code.

[Judge0 API](https://api.judge0.com) is a robust and scalable open-source (source code available on [GitHub](https://github.com/judge0/api)) online code execution system made by Judge0.

Judge0 API can help you build wide range of applications varying from competitive programming platforms,
educational and recruitment platforms, to online code editors and more.

To see Judge0 API in action, try [Judge0 IDE](https://ide.judge0.com) - free and open-source code editor that uses Judge0 API for executing the user’s source code. You can also try using a [dummy client](/dummy-client.html), which can help you explore and test almost all the features of Judge0 API.

## Official public API
Official public API is available at [https://api.judge0.com](https://api.judge0.com) and is maintained by Judge0 [creator](https://github.com/hermanzdosilovic).

Status page of all public Judge0 services is available at [https://status.judge0.com](https://status.judge0.com).

::: note
<h4>Note</h4>
* You **do not** need an authentication token (a.k.a. API key) for official public API.
* Official public API will always be at the latest available version.
:::

## Version
This document describes Judge0 API version [`v1.5.0-nim-latest`](https://github.com/judge0/api/tree/v1.5.0-nim-latest).

## Date and time formats
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

## License
Judge0 API is licensed under the [GNU General Public License v3.0](https://github.com/judge0/api/blob/master/LICENSE).

## Donate
Your are more than welcome to support Judge0 on [Patreon](https://www.patreon.com/hermanzdosilovic) or via [PayPal](https://www.paypal.me/hermanzdosilovic). Your monthly or one-time donation will help pay server costs and will improve future development and maintenance. Thank you ♥

<br>

<!-- include(authentication/authentication.md) -->
<!-- include(authorization/authorization.md) -->
<!-- include(submissions/submissions.md) -->
<!-- include(statuses_and_languages/statuses_and_languages.md) -->
<!-- include(system_and_configuration/system_and_configuration.md) -->
<!-- include(health_check/health_check.md) -->
<!-- include(information/information.md) -->
