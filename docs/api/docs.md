FORMAT: 1A
HOST: https://api.judge0.com

# Judge0 - API Documentation
<!-- include(hostname.html) -->
<!-- include(style.html) -->

## About
[Judge0](https://api.judge0.com) is a robust, scalable, and [open-source](https://github.com/judge0/judge0) **online code execution system** that can be used to build a wide range of applications that need online code execution features. Some examples include competitive programming platforms, e-learning platforms, candidate assessment and recruitment platforms, online code editors, online IDEs, and many more.

In our research paper [*Robust and Scalable Online Code Execution System*](https://paper.judge0.com) we present Judge0's modern modular architecture that can be easily deployed and scaled. We study its design, comment on the various challenges that arise in building such systems, and compare it with other available online code execution systems and online judge systems.

To see Judge0 in action, try [Judge0 IDE](https://ide.judge0.com) - our free and open-source online code editor. You can also try using a [dummy client](/dummy-client.html) which can help you explore and test most of the features of Judge0.

## Features
- Quick and easy [installation](#header-get-started)
- Rich and verbose [API documentation](https://api.judge0.com)
- Scalable architecture
- Sandboxed compilation and execution
- Support for [60+ languages](https://github.com/judge0/compilers#supported-languages)
- Compilation and execution of multi-file programs
- Support for additional files alongside the user's program
- Support for custom user-defined compiler options, command-line arguments, and time and memory limits
- Detailed execution results
- Webhooks (HTTP callbacks)

## Get Started
Start with the [**FREE Basic Plan**](https://rapidapi.com/hermanzdosilovic/api/judge0/pricing) on RapidAPI or [host it yourself](CHANGELOG.md#deployment-procedure).

**Why should you use Judge0 on RapidAPI?**

Our infrastructure behind RapidAPI allows you to focus on building your product and forget about the know-how of maintaining and scaling Judge0.

**RapidAPI plans are not (good) enough for you?**

Let's talk. [Contact us](mailto:hermanz.dosilovic@gmail.com).

## Flavors
Judge0 comes in two flavors: [Judge0](https://rapidapi.com/hermanzdosilovic/api/judge0) and [Judge0 Extra](https://rapidapi.com/hermanzdosilovic/api/judge0-extra). They differ mostly in the [supported languages](https://github.com/judge0/compilers#supported-languages).

You can find the source code for Judge0 on the [`master`](https://github.com/judge0/judge0/tree/master) branch, while the source code for Judge0 Extra can be found on the [`extra`](https://github.com/judge0/judge0/tree/extra) branch.

Judge0 Extra is also available on [RapidAPI](https://rapidapi.com/hermanzdosilovic/api/judge0-extra).

## Version
This document describes Judge0 [v1.12.0](https://github.com/judge0/judge0/tree/v1.12.0).

## Date and time formats
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

## License
Judge0 is licensed under the [GNU General Public License v3.0](https://github.com/judge0/judge0/blob/master/LICENSE).

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
