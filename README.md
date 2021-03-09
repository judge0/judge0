# Judge0 CE

[![Judge0 Wallpaper](https://minio.judge0.com/public/web/image.png)](https://ce.judge0.com)

[![License](https://img.shields.io/github/license/judge0/judge0?color=2185d0&style=flat-square)](LICENSE)
[![Release](https://img.shields.io/github/v/release/judge0/judge0?color=2185d0&style=flat-square)](https://github.com/judge0/judge0/releases)
[![Stars](https://img.shields.io/github/stars/judge0/judge0?color=2185d0&style=flat-square)](https://github.com/judge0/judge0/stargazers)

<a href="https://www.producthunt.com/posts/judge0-ide" target="_blank"><img src="https://api.producthunt.com/widgets/embed-image/v1/featured.svg?post_id=179885&theme=light" alt="" height="43px" /></a>
<a href="https://patreon.com/hermanzdosilovic" target="_blank"><img src="https://c5.patreon.com/external/logo/become_a_patron_button@2x.png" alt="" height="43px" /></a>
<a href="https://paypal.me/hermanzdosilovic" target="_blank"><img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" alt="Donate with PayPal" height="43px" /></a>

🔥 The most advanced open-source online code execution system in the world.

## Table of Contents
* [About](#about)
* [Features](#features)
* [Get Started](#get-started)
* [Flavors](#flavors)
* [Supported Languages](#supported-languages)
* [References](#references)
* [Community](#community)
* [Author and Contributors](#author-and-contributors)
* [Changelog](#changelog)
* [Special Thanks](#special-thanks)
* [Supporters](#supporters)
* [Donate](#donate)
* [License](#license)

## About
[Judge0](https://ce.judge0.com) is a robust, scalable, and [open-source](https://github.com/judge0/judge0) **online code execution system**. You can use it to build a wide range of applications that need online code execution features. Some examples include competitive programming platforms, e-learning platforms, candidate assessment and recruitment platforms, online code editors, online IDEs, and many more.

In our research paper [Robust and Scalable Online Code Execution System](https://paper.judge0.com), we present Judge0's modern modular architecture that can be easily deployed and scaled. We study its design, comment on the various challenges in building such systems, and compare it with other available online code execution systems and online judge systems.

To see Judge0 in action, try [Judge0 IDE](https://ide.judge0.com) - our free and open-source online code editor.

Easily integrate online code editor with code execution (a.k.a. online compiler) to your website with our [**embeddable web widgets**](https://judge0.com/#judge0-widgets).

## Features
- Quick and easy [installation](https://judge0.com/#pricing)
- Rich and verbose [API documentation](https://ce.judge0.com)
- Scalable architecture
- Sandboxed compilation and execution
- Support for [60+ languages](#supported-languages)
- Compilation and execution of multi-file programs
- Support for additional files alongside the user's program
- Support for custom user-defined compiler options, command-line arguments, and time and memory limits
- Detailed execution results
- Webhooks (HTTP callbacks)

For more information about these and other features, please [read the documentation](https://ce.judge0.com).

## Get Started
Feel free to start with the [**FREE Basic Plan**](https://judge0.com/ce) on RapidAPI or [host it yourself](https://github.com/judge0/judge0/blob/master/CHANGELOG.md#deployment-procedure).

You can find our detailed plans and pricing [here](https://judge0.com/#pricing).

### Why should you use Judge0 on RapidAPI?
Our infrastructure allows you to **focus on building your product** and forget about the know-how of maintaining and scaling Judge0.

### RapidAPI plans are not (good) enough for you?
Let's talk. [Contact us](mailto:contact@judge0.com).

## Flavors
Judge0 comes in two flavors: [Judge0 CE](https://judge0.com/ce) and [Judge0 Extra CE](https://judge0.com/extra-ce). They differ mostly in the [supported languages](#supported-languages).

You can find the source code for Judge0 CE on the [`master`](https://github.com/judge0/judge0/tree/master) branch, while you can find the source code for Judge0 Extra CE on the [`extra`](https://github.com/judge0/judge0/tree/extra) branch.

Judge0 Extra CE is also available on [RapidAPI](https://judge0.com/extra-ce).

## Supported Languages
Judge0 comes in two flavors: [Judge0 CE](https://judge0.com/ce) and [Judge0 Extra CE](https://judge0.com/extra-ce). They differ mostly in the [supported languages](#supported-languages).

### [Judge0 CE](https://judge0.com/ce)
<details><summary>Click here to expand the list</summary>
<table>
<thead>
<tr>
<th style="text-align:center">#</th>
<th style="text-align:center">Name</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center">1</td>
<td style="text-align:center">Assembly (NASM 2.14.02)</td>
</tr>
<tr>
<td style="text-align:center">2</td>
<td style="text-align:center">Bash (5.0.0)</td>
</tr>
<tr>
<td style="text-align:center">3</td>
<td style="text-align:center">Basic (FBC 1.07.1)</td>
</tr>
<tr>
<td style="text-align:center">4</td>
<td style="text-align:center">C (Clang 7.0.1)</td>
</tr>
<tr>
<td style="text-align:center">5</td>
<td style="text-align:center">C (GCC 7.4.0)</td>
</tr>
<tr>
<td style="text-align:center">6</td>
<td style="text-align:center">C (GCC 8.3.0)</td>
</tr>
<tr>
<td style="text-align:center">7</td>
<td style="text-align:center">C (GCC 9.2.0)</td>
</tr>
<tr>
<td style="text-align:center">8</td>
<td style="text-align:center">C# (Mono 6.6.0.161)</td>
</tr>
<tr>
<td style="text-align:center">9</td>
<td style="text-align:center">C++ (Clang 7.0.1)</td>
</tr>
<tr>
<td style="text-align:center">10</td>
<td style="text-align:center">C++ (GCC 7.4.0)</td>
</tr>
<tr>
<td style="text-align:center">11</td>
<td style="text-align:center">C++ (GCC 8.3.0)</td>
</tr>
<tr>
<td style="text-align:center">12</td>
<td style="text-align:center">C++ (GCC 9.2.0)</td>
</tr>
<tr>
<td style="text-align:center">13</td>
<td style="text-align:center">Clojure (1.10.1)</td>
</tr>
<tr>
<td style="text-align:center">14</td>
<td style="text-align:center">COBOL (GnuCOBOL 2.2)</td>
</tr>
<tr>
<td style="text-align:center">15</td>
<td style="text-align:center">Common Lisp (SBCL 2.0.0)</td>
</tr>
<tr>
<td style="text-align:center">16</td>
<td style="text-align:center">D (DMD 2.089.1)</td>
</tr>
<tr>
<td style="text-align:center">17</td>
<td style="text-align:center">Elixir (1.9.4)</td>
</tr>
<tr>
<td style="text-align:center">18</td>
<td style="text-align:center">Erlang (OTP 22.2)</td>
</tr>
<tr>
<td style="text-align:center">19</td>
<td style="text-align:center">Executable</td>
</tr>
<tr>
<td style="text-align:center">20</td>
<td style="text-align:center">F# (.NET Core SDK 3.1.202)</td>
</tr>
<tr>
<td style="text-align:center">21</td>
<td style="text-align:center">Fortran (GFortran 9.2.0)</td>
</tr>
<tr>
<td style="text-align:center">22</td>
<td style="text-align:center">Go (1.13.5)</td>
</tr>
<tr>
<td style="text-align:center">23</td>
<td style="text-align:center">Groovy (3.0.3)</td>
</tr>
<tr>
<td style="text-align:center">24</td>
<td style="text-align:center">Haskell (GHC 8.8.1)</td>
</tr>
<tr>
<td style="text-align:center">25</td>
<td style="text-align:center">Java (OpenJDK 13.0.1)</td>
</tr>
<tr>
<td style="text-align:center">26</td>
<td style="text-align:center">JavaScript (Node.js 12.14.0)</td>
</tr>
<tr>
<td style="text-align:center">27</td>
<td style="text-align:center">Kotlin (1.3.70)</td>
</tr>
<tr>
<td style="text-align:center">28</td>
<td style="text-align:center">Lua (5.3.5)</td>
</tr>
<tr>
<td style="text-align:center">29</td>
<td style="text-align:center">Objective-C (Clang 7.0.1)</td>
</tr>
<tr>
<td style="text-align:center">30</td>
<td style="text-align:center">OCaml (4.09.0)</td>
</tr>
<tr>
<td style="text-align:center">31</td>
<td style="text-align:center">Octave (5.1.0)</td>
</tr>
<tr>
<td style="text-align:center">32</td>
<td style="text-align:center">Pascal (FPC 3.0.4)</td>
</tr>
<tr>
<td style="text-align:center">33</td>
<td style="text-align:center">Perl (5.28.1)</td>
</tr>
<tr>
<td style="text-align:center">34</td>
<td style="text-align:center">PHP (7.4.1)</td>
</tr>
<tr>
<td style="text-align:center">35</td>
<td style="text-align:center">Plain Text</td>
</tr>
<tr>
<td style="text-align:center">36</td>
<td style="text-align:center">Prolog (GNU Prolog 1.4.5)</td>
</tr>
<tr>
<td style="text-align:center">37</td>
<td style="text-align:center">Python (2.7.17)</td>
</tr>
<tr>
<td style="text-align:center">38</td>
<td style="text-align:center">Python (3.8.1)</td>
</tr>
<tr>
<td style="text-align:center">39</td>
<td style="text-align:center">R (4.0.0)</td>
</tr>
<tr>
<td style="text-align:center">40</td>
<td style="text-align:center">Ruby (2.7.0)</td>
</tr>
<tr>
<td style="text-align:center">41</td>
<td style="text-align:center">Rust (1.40.0)</td>
</tr>
<tr>
<td style="text-align:center">42</td>
<td style="text-align:center">Scala (2.13.2)</td>
</tr>
<tr>
<td style="text-align:center">43</td>
<td style="text-align:center">SQL (SQLite 3.27.2)</td>
</tr>
<tr>
<td style="text-align:center">44</td>
<td style="text-align:center">Swift (5.2.3)</td>
</tr>
<tr>
<td style="text-align:center">45</td>
<td style="text-align:center">TypeScript (3.7.4)</td>
</tr>
<tr>
<td style="text-align:center">46</td>
<td style="text-align:center">Visual Basic<span>.</span>Net (vbnc 0.0.0.5943)</td>
</tr>
</tbody>
</table>
</details>

### [Judge0 Extra CE](https://judge0.com/extra-ce)
<details><summary>Click here to expand the list</summary>
<table>
<thead>
<tr>
<th style="text-align:center">#</th>
<th style="text-align:center">Name</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center">1</td>
<td style="text-align:center">Bosque (latest)</td>
</tr>
<tr>
<td style="text-align:center">2</td>
<td style="text-align:center">C (Clang 10.0.1)</td>
</tr>
<tr>
<td style="text-align:center">3</td>
<td style="text-align:center">C (Clang 9.0.1)</td>
</tr>
<tr>
<td style="text-align:center">4</td>
<td style="text-align:center">C# (.NET Core SDK 3.1.302)</td>
</tr>
<tr>
<td style="text-align:center">5</td>
<td style="text-align:center">C# (Mono 6.10.0.104)</td>
</tr>
<tr>
<td style="text-align:center">6</td>
<td style="text-align:center">C# Test (.NET Core SDK 3.1.302, NUnit 3.12.0)</td>
</tr>
<tr>
<td style="text-align:center">7</td>
<td style="text-align:center">C++ (Clang 10.0.1)</td>
</tr>
<tr>
<td style="text-align:center">8</td>
<td style="text-align:center">C++ (Clang 9.0.1)</td>
</tr>
<tr>
<td style="text-align:center">9</td>
<td style="text-align:center">C++ Test (Clang 10.0.1, Google Test 1.8.1)</td>
</tr>
<tr>
<td style="text-align:center">10</td>
<td style="text-align:center">C++ Test (GCC 8.4.0, Google Test 1.8.1)</td>
</tr>
<tr>
<td style="text-align:center">11</td>
<td style="text-align:center">C3 (latest)</td>
</tr>
<tr>
<td style="text-align:center">12</td>
<td style="text-align:center">F# (.NET Core SDK 3.1.302)</td>
</tr>
<tr>
<td style="text-align:center">13</td>
<td style="text-align:center">Java (OpenJDK 14.0.1)</td>
</tr>
<tr>
<td style="text-align:center">14</td>
<td style="text-align:center">Java Test (OpenJDK 14.0.1, JUnit Platform Console Standalone 1.6.2)</td>
</tr>
<tr>
<td style="text-align:center">15</td>
<td style="text-align:center">MPI (OpenRTE 3.1.3) with C (GCC 8.4.0)</td>
</tr>
<tr>
<td style="text-align:center">16</td>
<td style="text-align:center">MPI (OpenRTE 3.1.3) with C++ (GCC 8.4.0)</td>
</tr>
<tr>
<td style="text-align:center">17</td>
<td style="text-align:center">MPI (OpenRTE 3.1.3) with Python (3.7.7)</td>
</tr>
<tr>
<td style="text-align:center">18</td>
<td style="text-align:center">Nim (stable)</td>
</tr>
<tr>
<td style="text-align:center">19</td>
<td style="text-align:center">Python for ML (3.7.7)</td>
</tr>
<tr>
<td style="text-align:center">20</td>
<td style="text-align:center">Visual Basic<span>.</span>Net (vbnc 0.0.0.5943)</td>
</tr>
</tbody>
</table>
</details>

## References

### Companies, Organizations, and Projects
These companies, organizations, and projects successfully use Judge0.

<details><summary>Click here to expand the list</summary>
<ul>
<li><a href="https://adzetech.com">Adzetech</a></li>
<li><a href="https://algodaily.com">AlgoDaily</a></li>
<li><a href="http://algoladder.com">AlgoLadder</a></li>
<li><a href="https://www.asktohow.com">Ask To How</a></li>
<li><a href="https://www.brillianthire.io">Brilliant Hire</a></li>
<li><a href="https://code.in">CODE.IN</a></li>
<li><a href="https://play.google.com/store/apps/details?id=com.codefox.code_compiler_lite">Code Compiler Lite</a> - online mobile code compiler for Android</li>
<li><a href="https://code4you.org">Code4You</a></li>
<li><a href="https://www.codechum.com">CodeChum</a></li>
<li><a href="https://github.com/appsicle/CodeClimbers">CodeClimbers</a></li>
<li><a href="https://codeforum.org">Code Forum</a></li>
<li><a href="https://codeinn.org">CodeInn</a></li>
<li><a href="https://github.com/KamandPrompt/CodeManiacs">CodeManiacs</a> - an online judge for <a href="http://www.iitmandi.ac.in">IIT Mandi</a></li>
<li><a href="https://github.com/codeclassroom/CodeRunner">CodeRunner</a></li>
<li><a href="http://codesites.in">Codesites</a></li>
<li><a href="https://codify.herokuapp.com">Codify</a></li>
<li><a href="https://www.dev-coach.com">DevCoach</a></li>
<li><a href="http://www.duvlab.website">Dilla University</a></li>
<li><a href="https://www.filtered.ai">Filtered</a></li>
<li><a href="http://www.geekcoders.co.in">GeekCoders</a></li>
<li><a href="https://www.uni-goettingen.de">Georg-August University of Göttingen</a></li>
<li><a href="https://gomycode.co">GoMyCode</a></li>
<li><a href="https://www.hackademy.mx">Hackademy</a></li>
<li><a href="https://github.com/YashKumarVerma/rc-heimdall">Heimdall</a></li>
<li><a href="http://www.iitmandi.ac.in">Indian Institute of Technology Mandi</a></li>
<li><a href="https://instacks.in">Instacks</a></li>
<li><a href="https://www.iare.ac.in">Institute of Aeronautical Engineering</a></li>
<li><a href="https://interviewsandbox.com">Interview Sandbox</a></li>
<li><a href="https://github.com/bloodnighttw/JavaJudge0Api">JavaJudge0Api</a> - a Java library for interacting with Judge0</li>
<li><a href="http://en.chamcode.net">Judge Code Online</a></li>
<li><a href="https://www.kpriet.ac.in">KPR Institute of Engineering and Technology</a></li>
<li><a href="http://www.kodkarate.in">KodKarate</a> - an open-source IDE</li>
<li><a href="https://www.kodnest.com">KodNest</a></li>
<li><a href="https://github.com/MartyMiniac/Autorun">MartyMiniac/Autorun</a></li>
<li><a href="https://myedukit.com/coders/online-compiler">MyEduKit</a></li>
<li><a href="http://newscad.com">NewsCad</a></li>
<li><a href="https://www.newtonschool.co">Newton School</a></li>
<li><a href="https://picode.now.sh">Picode</a> - an online code playground</li>
<li><a href="https://github.com/Pravinkanna/codeaholic">Pravinkanna/codeaholic</a></li>
<li><a href="https://prepfortech.in">PrepForTech</a></li>
<li><a href="https://reva.edu.in">REVA University</a></li>
<li><a href="https://softcodeon.com">Soft CodeOn</a></li>
<li><a href="https://sparkdatabox.com">SparkDatabox</a></li>
<li><a href="https://github.com/StardustDL/StarOJ">StarOJ</a> - An online judge platform based on Judge0</li>
<li><a href="https://github.com/StardustDL/judge0-dotnet">StardustDL/judge0-dotnet</a> - Client SDK for Judge0</li>
<li><a href="https://stemalica.com">Stemalica</a></li>
<li><a href="https://studyfied.com">Studyfied</a></li>
<li><a href="https://techiedelight.com">Techie Delight</a></li>
<li><a href="https://www.thinkexam.com">Think exam</a></li>
<li><a href="https://www.thinkingbell.com">ThinkingBell</a></li>
<li><a href="https://www.fer.unizg.hr/en">University of Zagreb, Faculty of Electrical Engineering and Computing</a></li>
<li><a href="https://apps.apple.com/US/app/id1512938504">VS Code App</a> - lightweight universal IDE for iOS / iPadOS with full iCloud Drive support</li>
<li><a href="https://xiith.com">Xiith</a></li>
<li><a href="https://github.com/anu0912/online-code-editor">anu0912/online-code-editor</a></li>
<li><a href="https://github.com/TopRoupi/judge0-gem">judge0-gem</a> - Ruby Gem for interacting with Judge0</li>
<li><a href="https://github.com/saikatharryc/judge0_helm">judge0_helm</a> - Helm Chart for Judge0</li>
<li><a href="https://github.com/vCra/judge0api">judge0api</a> - Python library for interacting with Judge0</li>
<li><a href="https://github.com/muzam1l/ide">muzam1l/ide</a></li>
<li><a href="https://ngrader.herokuapp.com">nGrader</a></li>
<li><a href="http://primat.org">primat.org</a></li>
<li><a href="https://github.com/tracyliu1220/Mini-OJ">tracyliu1220/Mini-OJ</a></li>
<li><a href="https://www.udebugtool.com">uDebug Tool</a></li>
<li><a href="http://wkspace.herokuapp.com">wkspace</a></li>
<li><a href="https://www.yocode.in">yoCode</a></li>
<li><a href="https://zbirka.online">Zbirka Online</a></li>
</ul>
</details>

### Scientific Articles
These scientific articles use or mention Judge0.

<details><summary>Click here to expand the list</summary>
<ul>
<li><a href="https://dl.acm.org/doi/10.1145/3328778.3372610">A Game-Changing Instructor Tool to Reinforce Coding Concepts</a></li>
<li><a href="https://ieeexplore.ieee.org/document/9079865">Building a Comprehensive Automated Programming Assessment System</a></li>
<li><a href="https://link.springer.com/chapter/10.1007/978-981-15-3607-6_5">Voice-Enabled Intelligent IDE in Cloud</a></li>
</ul>
</details>

### Other Online References
<details><summary>Click here to expand the list</summary>
<ul>
<li><a href="https://tianpan.co/notes/243-designing-online-judge-or-leetcode">Designing Online Judge or Leetcode</a></li>
<li><a href="https://medium.com/@akashgp09/make-your-own-online-compiler-in-react-%EF%B8%8F-b06bc29dd202">Make your own online compiler in React</a></li>
<li><a href="https://youtu.be/mq18_oSNkHE?t=966">Programski jezik Go - FER 2019./2020. - Prvo predavanje</a></li>
<li><a href="https://www.fer.unizg.hr/novosti?@=2qzoy#">Sudjelovanje FER-a na Smotri Sveučilišta 2019.</a></li>
<li><a href="https://www.fer.unizg.hr/novosti?@=2r0st#">Svečana 672. sjednica Fakultetskog vijeća FER-a</a></li>
<li><a href="https://usaco.guide/general/running-code-online">USACO Guide - Running Code Online</a></li>
<li><a href="https://repozitorij.fer.unizg.hr/en/islandora/object/fer%3A3607">Web application for authoring and sharing code snippets in different programming languages
</a></li>
<li><a href="https://medium.com/javarevisited/lets-deploy-our-online-code-executor-in-google-cloud-e76a9fabac57">Let’s Deploy our Online Code Executor in Google Cloud</a></li>
<li><a href="https://levelup.gitconnected.com/lets-develop-an-online-code-editor-compiler-like-hackerrank-c433d8db060d">Let’s Develop an Online Code Editor & Compiler like HackerRank</a></li>
<li><a href="https://medium.com/javascript-in-plain-english/lets-develop-an-online-code-editor-compiler-like-hackerrank-702881803eee">Let’s Develop An Online Code Editor/Compiler Like HackerRank</a></li>
</ul>
</details>

## Community
Do you have a question, feature request, or something else on your mind? Or you want to follow Judge0 news?

* [Subscribe to Judge0 newsletter](https://subscribe.judge0.com)
* [Join our Discord server](https://discord.gg/GRc3v6n)
* [Watch asciicasts](https://asciinema.org/~hermanzdosilovic)
* [Report an issue](https://github.com/judge0/judge0/issues/new)
* [Contact us](mailto:contact@judge0.com)
* [Schedule an online meeting with us](https://judge0.appointlet.com)

## Author and Contributors
Judge0 was created and is maintained by [Herman Zvonimir Došilović](https://github.com/hermanzdosilovic).

Thanks a lot to all [contributors](https://github.com/judge0/judge0/graphs/contributors) for their contributions to this project.

<a href="https://github.com/judge0/judge0/graphs/contributors">
  <img src="https://contributors-img.web.app/image?repo=judge0/judge0" />
</a>

## Changelog
You can find the detailed specification of changes between versions in [CHANGELOG.md](CHANGELOG.md).

## Special Thanks
Special thanks to open-source projects without whom Judge0 probably wouldn't exist: [Isolate](https://github.com/ioi/isolate), [Docker](https://github.com/docker), [Ruby on Rails](https://github.com/rails/rails) and others.

## Supporters
Thanks a lot to all [Patrons](https://www.patreon.com/hermanzdosilovic) and [PayPal](https://paypal.me/hermanzdosilovic) donors that support Judge0 development. Thank you! ♥

## Donate
Your are more than welcome to support Judge0 development on [Patreon](https://www.patreon.com/hermanzdosilovic), via [PayPal](https://paypal.me/hermanzdosilovic) or [Revolut](https://pay.revolut.com/profile/hermancy5). Thank you.

## License
Judge0 is licensed under the [GNU General Public License v3.0](LICENSE).
