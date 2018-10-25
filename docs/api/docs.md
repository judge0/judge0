FORMAT: 1A
HOST: https://api.judge0.com

# Judge0 API
<!-- include(hostname.html) -->
<!-- include(style.html) -->
<!-- include(ga.html) -->

## About
[Judge0](https://judge0.com) is an [open source](https://github.com/judge0) project that creates free and open source tools
and services for executing and grading untrusted source code.

[Judge0 API](https://api.judge0.com) is an [open source](https://github.com/judge0/api) project of Judge0 and a web API for source code compilation
and execution that allows you to execute source code in sandboxed environment in more than 40 compilers and interpreters.<br>
Full list of available compilers and interpreters can be found [here](/languages).

Judge0 API can help you create your own system that needs a robust and secure way of executing source code.

With Judge0 API you can easly create:
* collaborative code editor,
* competitive programming platform,
* candidate interview application,
* e-learning system and
* etc.

To see Judge0 API in action, try [Judge0 IDE](https://ide.judge0.com) - simple open source code editor that uses Judge0 API for executing user's source code.

## Official public API
Official public API is available at [https://api.judge0.com](https://api.judge0.com) and is maintained by Judge0 [creator](https://github.com/hermanzdosilovic).

Status page of public Judge0 services is available [here](https://status.judge0.com).

::: note
<h4>Note</h4>
* You **do not** need an authentication token (a.k.a. API key) for official public API.
* Official public API will always be at the latest version.
:::

## Version
This document describes Judge0 API version [`v2.0.0`](https://github.com/judge0/api/tree/v2.0.0).
Documentation for older versions can be found [here](https://static.judge0.com/api/docs/).

## Date and time formats
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

## License
Judge0 API is licensed under the [GNU General Public License v3.0](https://github.com/judge0/api/blob/v2.0.0/LICENSE).

## Donate
If you like Judge0, please consider making a [donation](https://www.paypal.me/hermanzdosilovic) to support this project.
Your donation will help keep the servers running.

</br>

<!-- include(authentication/authentication.md) -->
<!-- include(authorization/authorization.md) -->
<!-- include(submissions/submissions.md) -->
<!-- include(statuses_and_languages/statuses_and_languages.md) -->
<!-- include(system_and_configuration/system_and_configuration.md) -->
<!-- include(health_check/health_check.md) -->
