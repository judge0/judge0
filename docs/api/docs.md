FORMAT: 1A
HOST: https://api.judge0.com

# Judge0 - API Documentation
<!-- include(hostname.html) -->
<!-- include(style.html) -->

## About
[Judge0](https://api.judge0.com) is a robust and scalable [open-source](https://github.com/judge0/api) online code execution system. It can be used to build a wide range of applications varying from competitive programming platforms, educational and recruitment platforms, to online code editors, and more.

To see Judge0 in action, try [Judge0 IDE](https://ide.judge0.com) - a free and [open-source](https://github.com/judge0/ide) online code editor that uses Judge0 for executing the user’s source code. You can also try using a [dummy client](/dummy-client.html) which can help you explore and test most of the features of Judge0.

## Features
- Quick and easy [installation](https://github.com/judge0/api#installation).
- Supports more than [45 languages](https://github.com/judge0/api-base#supported-languages).
- Runs source code in a secure and reliable [sandbox](https://github.com/ioi/isolate).
- Send multiple source code files and any other files. [Demo](https://asciinema.org/a/318548).
- Set custom compiler options. [Demo](https://ide.judge0.com/?PfcV).
- Set custom command line arguments. [Demo](https://ide.judge0.com/?E68R).
- Set time and memory limits.
- HTTP callbacks.
- And [many more](https://api.judge0.com/#submissions-submission).

## Get Started
Choose a plan on [RapidAPI](https://rapidapi.com/hermanzdosilovic/api/judge0/pricing) or [install](https://github.com/judge0/api#installation) on your own server.

## Research Paper
You can read a research paper about Judge0 [here](https://minio.judge0.com/public/paper-in-review.pdf).

## Version
This document describes Judge0 [v1.9.0](https://github.com/judge0/api/tree/v1.9.0).

## Date and time formats
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

## License
Judge0 is licensed under the [GNU General Public License v3.0](https://github.com/judge0/api/blob/master/LICENSE).

## Donate
Your are more than welcome to support Judge0 development on [Patreon](https://www.patreon.com/hermanzdosilovic), via [PayPal](https://paypal.me/hermanzdosilovic) or [Revolut](https://pay.revolut.com/profile/hermancy5).

<br>

<!-- include(authentication/authentication.md) -->
<!-- include(authorization/authorization.md) -->
<!-- include(submissions/submissions.md) -->
<!-- include(statuses_and_languages/statuses_and_languages.md) -->
<!-- include(system_and_configuration/system_and_configuration.md) -->
<!-- include(statistics/statistics.md) -->
<!-- include(health_check/health_check.md) -->
<!-- include(information/information.md) -->
