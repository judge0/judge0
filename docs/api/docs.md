FORMAT: 1A
HOST: https://ce.judge0.com

# Judge0 CE - API Docs
<!-- include(hostname.html) -->
<!-- include(style.html) -->

## About
[Judge0](https://ce.judge0.com) is a robust, scalable, and [open-source](https://github.com/judge0/judge0) **online code execution system**. You can use it to build a wide range of applications that need online code execution features. Some examples include competitive programming platforms, e-learning platforms, candidate assessment and recruitment platforms, online code editors, online IDEs, and many more.

In our research paper [Robust and Scalable Online Code Execution System](https://paper.judge0.com), we present Judge0's modern modular architecture that can be easily deployed and scaled. We study its design, comment on the various challenges in building such systems, and compare it with other available online code execution systems and online judge systems.

To see Judge0 in action, try [Judge0 IDE](https://ide.judge0.com) - our free and open-source online code editor. You can also try using a [dummy client](/dummy-client.html) that can help you explore and test most of the features of Judge0.

Easily integrate online code editor with code execution (a.k.a. online compiler) to your website with our [**embeddable web widgets**](https://judge0.com/#judge0-widgets).

## Features
<ul style="list-style: none; padding-left: 1em;">
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Quick and easy <a href="https://judge0.com/#pricing">installation</a></li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Rich and verbose <a target="_blank" href="https://ce.judge0.com">API documentation</a></li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Scalable architecture</li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Sandboxed compilation and execution</li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Support for <a target="_blank" href="https://github.com/judge0/judge0#supported-languages">60+ languages</a></li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Compilation and execution of multi-file programs</li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Support for additional files alongside the user's program</li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Support for custom user-defined compiler options, command-line arguments, and time and memory limits</li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Detailed execution results</li>
    <li><i style="color: #69DB7C; margin-right: 0.1em;" class="fas fa-check-circle"></i> Webhooks (HTTP callbacks)</li>
</ul>

## Get Started
Get started with Judge0 today on [**Sulu**](https://sparkhub.sulu.sh/apis/judge0/judge0-ce/readme) and get [**20K Free Submissions**](https://sparkhub.sulu.sh/auth/signup) to try it when you sign up.


You can also get started with the [**FREE Basic Plan**](https://judge0.com/ce) on RapidAPI or [host it yourself](https://github.com/judge0/judge0/blob/master/CHANGELOG.md#deployment-procedure).

You can find our detailed plans and pricing [here](https://judge0.com/#pricing).

**Why should you use Judge0 on Sulu or RapidAPI?**
    
Our infrastructure allows you to **focus on building your product** and forget about the know-how of maintaining and scaling Judge0.

**Sulu or RapidAPI plans are not (good) enough for you?**

Let's talk. [Contact us](mailto:contact@judge0.com).

## Flavors
Judge0 comes in two flavors: [Judge0 CE](https://judge0.com/ce) and [Judge0 Extra CE](https://judge0.com/extra-ce). They differ mostly in the [supported languages](https://github.com/judge0/judge0#supported-languages).

You can find the source code for Judge0 CE on the [`master`](https://github.com/judge0/judge0/tree/master) branch, while you can find the source code for Judge0 Extra CE on the [`extra`](https://github.com/judge0/judge0/tree/extra) branch.

Judge0 Extra CE is also available on [RapidAPI](https://judge0.com/extra-ce).

## Version
This document describes Judge0 CE [v1.13.0](https://github.com/judge0/judge0/tree/v1.13.0).

## Date and time formats
[ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) standard is used.

Example: `2016-09-11T10:19:35Z`

## License
Judge0 is licensed under the [GNU General Public License v3.0](https://github.com/judge0/judge0/blob/master/LICENSE).

## Donate
Your are more than welcome to support Judge0 development on [Patreon](https://www.patreon.com/hermanzdosilovic), via [PayPal](https://paypal.me/hermanzdosilovic) or [Revolut](https://pay.revolut.com/profile/hermancy5). Thank you.

<br>

<!-- include(authentication/authentication.md) -->
<!-- include(authorization/authorization.md) -->
<!-- include(submissions/submissions.md) -->
<!-- include(statuses_and_languages/statuses_and_languages.md) -->
<!-- include(system_and_configuration/system_and_configuration.md) -->
<!-- include(statistics/statistics.md) -->
<!-- include(health_check/health_check.md) -->
<!-- include(information/information.md) -->
