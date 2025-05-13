[![Judge0 Wallpaper](./.github/judge0-colored.png)](https://ce.judge0.com)
# Judge0

[![License](https://img.shields.io/github/license/judge0/judge0?color=2185d0&style=flat-square)](LICENSE)
[![Release](https://img.shields.io/github/v/release/judge0/judge0?color=2185d0&style=flat-square)](https://github.com/judge0/judge0/releases)
[![Stars](https://img.shields.io/github/stars/judge0/judge0?color=2185d0&style=flat-square)](https://github.com/judge0/judge0/stargazers)

Robust, scalable, and open-source online code execution system.

## Table of Contents
* [About](#about)
* [Features](#features)
* [Get Started](#get-started)
* [Flavors](#flavors)
* [Supported Languages](#supported-languages)
* [References](#references)
* [Showcase](#showcase)
* [Citation](#citation)
* [Community](#community)
* [Author and Contributors](#author-and-contributors)
* [Changelog](#changelog)
* [Special Thanks](#special-thanks)
* [License](#license)

## About
[Judge0](https://judge0.com) (pronounced like "judge zero") is a robust, scalable, and [open-source](https://github.com/judge0/judge0) **online code execution system**. You can use it to build a wide range of applications that need online code execution features. Some examples include competitive programming platforms, e-learning platforms, candidate assessment and recruitment platforms, online code editors, online IDEs, and many more.

In our research paper [Robust and Scalable Online Code Execution System](https://paper.judge0.com), we present Judge0's modern modular architecture that can be easily deployed and scaled. We study its design, comment on the various challenges in building such systems, and compare it with other available online code execution systems and online judge systems.

To see Judge0 in action, try [Judge0 IDE](https://ide.judge0.com) - our free and open-source online code editor.

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
Get started with Judge0 today on [**Sulu**](https://sparkhub.sulu.sh/apis/judge0/judge0-ce/readme) and get [**20K Free Submissions**](https://sparkhub.sulu.sh/auth/signup) to try it when you sign up.

You can also get started with the [**FREE Basic Plan**](https://judge0.com/ce) on RapidAPI or [host it yourself](https://github.com/judge0/judge0/blob/master/CHANGELOG.md#deployment-procedure).

You can find our detailed plans and pricing [here](https://judge0.com/#pricing). So far our clients have run with us more than ![](https://img.shields.io/endpoint?color=2185d0&style=flat-square&url=https%3A%2F%2Fjudge0.com%2Fstatistics-badge) programs.

### Why should you use Judge0 on Sulu or RapidAPI?
Our infrastructure allows you to **focus on building your product** and forget about the know-how of maintaining and scaling Judge0.

### Sulu or RapidAPI plans are not (good) enough for you?
Let's talk. [Contact us](mailto:contact@judge0.com).

## Flavors
Judge0 comes in two flavors: [Judge0 CE](https://judge0.com/ce) and [Judge0 Extra CE](https://judge0.com/extra-ce). They differ mostly in the [supported languages](#supported-languages).

You can find the source code for Judge0 CE on the [`master`](https://github.com/judge0/judge0/tree/master) branch, while you can find the source code for Judge0 Extra CE on the [`extra`](https://github.com/judge0/judge0/tree/extra) branch.

Judge0 Extra CE is also available on [Sulu](https://judge0.com/extra-ce) and [RapidAPI](https://judge0.com/extra-ce).

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

### Industry
[These companies, institutions, and organizations use Judge0.](https://judge0.com/#clients)

### Academia
These scientific articles cite Judge0.

* [A Game-Changing Instructor Tool to Reinforce Coding Concepts](https://dl.acm.org/doi/10.1145/3328778.3372610)
* [A ML-Based Stock Trading Model for Profit Predication](https://www.researchgate.net/publication/353328644_A_ML-Based_Stock_Trading_Model_for_Profit_Predication)
* [A Secure and Scalable System for Online Code Execution and Evaluation using Containerization and Kubernetes](https://www.jetir.org/papers/JETIR2302226.pdf)
* [A Secure, Scalable, and Integrated Smart Platform for Teaching and Coding](https://www.taylorfrancis.com/chapters/edit/10.1201/9781032673479-20/secure-scalable-integrated-smart-platform-teaching-coding-mohit-dua-giri-sainath-reddy-ramesh-vishnoi-satyam-tomar-shelza-dua)
* [A Strategy Based on Technological Maps for the Identification of the State-of-the-Art Techniques in Software Development Projects: Virtual Judge Projects as a Case Study](https://link.springer.com/chapter/10.1007/978-3-319-98998-3_27)
* [A comparison between online compilers: A Case Study](https://ieeexplore.ieee.org/document/9797096/)
* [ADAPTIVE MENTORING WITH IMMEDIATE FEEDBACK FOR THE DEVELOPMENT OF PROGRAMMING SKILLS](https://library.iated.org/view/PEREZROJAS2024ADA)
* [Advanced lab analysis system using apache spark](https://pubs.aip.org/aip/acp/article/2492/1/030016/2892049)
* [Analiza performansi sustava za udaljeno izvršavanje programskog kôda](https://repozitorij.fer.unizg.hr/islandora/object/fer%3A7913)
* [Artificial Intelligence and Computer-Supported Collaborative Learning in Programming: A Systematic Mapping Study](http://ref.scielo.org/bmd4hy)
* [Automatic Evaluation of Student Software Solutions in a Virtualized Environment](https://ieeexplore.ieee.org/document/10159927)
* [Automatic marking system for programming subject](http://eprints.utar.edu.my/5990/)
* [Automatic question generation for JavaScript programming courses](https://ntnuopen.ntnu.no/ntnu-xmlui/handle/11250/3088497)
* [Big Data based Advanced Lab Analysis System using Apache Spark](https://ieeexplore.ieee.org/abstract/document/9489186)
* [Building a Comprehensive Automated Programming Assessment System](https://ieeexplore.ieee.org/document/9079865)
* [CODEGEN: A React-Based Online Coding Workspace with Advanced Features and Real-Time Execution](https://www.researchgate.net/publication/386243931_CODEGEN_A_React-Based_Online_Coding_Workspace_with_Advanced_Features_and_Real-Time_Execution)
* [Canvas Coding: una piattaforma di gioco per studenti basata sulla programmazione creativa = Canvas Coding: a gaming platform for students based on creative programming](https://webthesis.biblio.polito.it/29496/)
* [Code Verse](https://www.researchgate.net/publication/381988455_Code_Verse)
* [CodeCoach: An Interactive ProgrammingAssistance Tool](https://www.researchgate.net/publication/376610279_CodeCoach_An_Interactive_ProgrammingAssistance_Tool)
* [Computing students’ design preferences and barriers when solving short programming problems](https://peer.asee.org/computing-students-design-preferences-and-barriers-when-solving-short-programming-problems)
* [Creating a Platform for Competitive Programming Training with Integration of Automatic Decision Checking System](https://www.researchgate.net/publication/391464412_Creating_a_Platform_for_Competitive_Programming_Training_with_Integration_of_Automatic_Decision_Checking_System)
* [Dataset for Validation and Performance Testing of Online Judges](https://revistas.setrem.com.br/index.php/reabtic/article/view/462/225)
* [Desarrollo de una plataforma orientada al refuerzo en la evaluación del nivel de programación](https://oa.upm.es/63124/)
* [Desenvolvimento de um software Web para auxiliar o processo de ensino-aprendizagem da disciplina de Introdução à Ciência da Computação (ICC) da UNESP - Instituto de Ciência e Tecnologia de Sorocaba](https://repositorio.unesp.br/items/145d27dd-354b-45ee-b465-ef9e9b25d03f)
* [Designing a Platform to Train Secure Programming Skills With Attack-and-Defend Exercises](https://people.cs.vt.edu/tilevich/papers/educon2025.pdf)
* [Development of a System for Automated Testing of Program Code for the Educational Process in the Discipline "Programming Languages](https://geosib.sgugit.ru/upload/geosibir/sborniki/2023/tom-7-1/164-171.pdf)
* [ECCO: Can We Improve Model-Generated Code Efficiency Without Sacrificing Functional Correctness?](https://arxiv.org/abs/2407.14044)
* [Evaluation of an Online Judge for Concurrent Programming Learning](https://ieeexplore.ieee.org/abstract/document/10346201)
* [Exploiter le Language Server Protocol pour créer un éditeur de code nomade et ergonomique](https://pure.unamur.be/ws/portalfiles/portal/98847091/2024_LoirS_Memoire.pdf)
* [Exploring Automated Code Evaluation Systems and Resources for Code Analysis: A Comprehensive Survey](https://arxiv.org/abs/2307.08705)
* [Full-stack web development for auto-assessment platform](https://dr.ntu.edu.sg/handle/10356/162927)
* [Grid-Coding: An Accessible, Efficient, and Structured Coding Paradigm for Blind and Low-Vision Programmers](https://dl.acm.org/doi/abs/10.1145/3526113.3545620)
* [JediCode -- A Gamefied Approach to Competitive Coding](https://arxiv.org/abs/2311.10244)
* [Large Language Models in der Berufsausbildung von IT-Fachkräften]()
* [MAGECODE: Machine-Generated Code Detection Method Using Large Language Models](https://ieeexplore.ieee.org/abstract/document/10772217)
* [Modul za obavljanje korisnički definiranih programa u sustavu za automatsko ocjenjivanje programskog kôda Edgar](https://repozitorij.fer.unizg.hr/en/islandora/object/fer%3A12816)
* [Nacionalni repozitorij završnih i diplomskih radova ZIR](https://zir.nsk.hr/islandora/search/dabar_search_keywords_mt:(%22Judge0%22))
* [Online Automatic Assessment System for Program Code: Architecture and Experiences](https://www.researchgate.net/publication/353329318_Online_Automatic_Assessment_System_for_Program_Code_Architecture_and_Experiences)
* [Online Judge System: Requirements, Architecture, and Experiences](https://www.worldscientific.com/doi/10.1142/S0218194022500346)
* [PEERLINK: A Comprehensive Collaborative Platform](https://ijsrset.com/index.php/home/article/view/IJSRSET25122209)
* [PERSSISTANT: A Progress Estimation System to Personalize Learning Trajectories](https://documentserver.uhasselt.be/handle/1942/44162)
* [Pengembangan Sistem Manajemen Evaluasi Pembelajaran Terintegrasi Dengan Online Judge](https://journals.upi-yai.ac.id/index.php/ikraith-informatika/article/view/1405)
* [Predviđanje uspjeha studenata u sustavu za automatsko ocjenjivanje programskog kôda Edgar](https://repozitorij.unizg.hr/islandora/object/fer:12103)
* [Programmable Questions in Edgar](https://ieeexplore.ieee.org/abstract/document/10159897)
* [Prototip integracije sustava za strojno učenje u sustav Edgar](https://repozitorij.fer.unizg.hr/islandora/object/fer%3A10234)
* [Protótipo de uma ferramenta gamificada para a aplicação de atividades práticas em sala de aula em uma disciplina de introdução à programação](http://repositorio.uft.edu.br/handle/11612/3789)
* [Rancang Bangun Sistem Online Judge dan Pendeteksian Plagiarisme Menggunakan Arsitektur Serverless](https://journal.unesa.ac.id/index.php/jieet/article/view/8363)
* [Repozitorij Fakulteta elektrotehnike i računarstva Sveučilišta u Zagrebu](https://repozitorij.fer.unizg.hr/islandora/search/dabar_search_keywords_mt:(%22Judge0%22))
* [Requirements for an Online Integrated Development Environment for Automated Programming Assessment Systems](https://www.eduardfrankford.com/pdfs/CSEDU2024.pdf)
* [Robust and Scalable Online Code Execution System](https://www.researchgate.net/publication/346751837_Robust_and_Scalable_Online_Code_Execution_System)
* [Scaling Automated Programming Assessment Systems](https://www.researchgate.net/publication/368528043_Scaling_Automated_Programming_Assessment_Systems)
* [Software de retos de programación](https://repositorio.tdea.edu.co/handle/tdea/3593)
* [Thinking beyond chatbots' threat to education: Visualizations to elucidate the writing and coding process](https://www.mdpi.com/2474186)
* [Usability and Security of Trusted Platform Module (TPM) Library APIs](https://www.usenix.org/conference/soups2022/presentation/rao)
* [Voice-Enabled Intelligent IDE in Cloud](https://link.springer.com/chapter/10.1007/978-981-15-3607-6_5)
* [Web aplikacija za provjeru programskog koda](https://repozitorij.etfos.hr/en/islandora/object/etfos:3574)
* [Web sustav za automatsku provjeru i vrednovanje programskih rješenja](https://www.unirepository.svkri.uniri.hr/islandora/object/riteh:4684)
* [Web-aplikacija za obavljanje i dijeljenje programskih odsječaka u različitim programskim jezicima](https://repozitorij.fer.unizg.hr/islandora/object/fer%3A3607)
* [Web-aplikacija za rješavanje programskih zadataka s elementima društvene mreže](https://repozitorij.fer.unizg.hr/islandora/object/fer%3A9899)
* [Yet Another Coding Platform (YACP)](https://research.engr.oregonstate.edu/si-lab/archive/2023_rohit.pdf)
* [«SYNCODING» - COLLABORATIVE CODE WRITING](https://ikee.lib.auth.gr/record/359400)
* [Видеомессенджер для совместной работой над кодом](https://elar.urfu.ru/handle/10995/135781)
* [ПОЯСНЮВАЛЬНА ЗАПИСКА ДО БАКАЛАВРСЬКОЇ РОБОТИ на тему ТРЕНАЖЕР З ТЕМИ «ПОБУДОВА БЛОК-СХЕМ АЛГОРИТМІВ ЦИКЛІЧНОЇ СТРУКТУРИ НА ПРИКЛАДІ ЦИКЛУ WHILE» ДИСТАНЦІЙНОГО НАВЧАЛЬНОГО КУРСУ «ПРОГРАМУВАННЯ ІІ» ТА РОЗРОБКА ЙОГО ПРОГРАМНОГО ЗАБЕЗПЕЧЕННЯ](http://dspace.puet.edu.ua/handle/123456789/11371)
* [Платформа для спільної роботи викладача та студента під час іспиту](https://ela.kpi.ua/handle/123456789/31297)
* [Розробка структури та програмна реалізація інтерфейсу WEB-редактора](http://dp.knute.edu.ua/jspui/bitstream/123456789/8142/1/%D0%92%D0%9A%D0%A0_%D0%9A%D0%BE%D0%B2%D1%82%D1%83%D0%BD_%D0%A4%D0%86%D0%A2%20%204-10.pdf)

### Other Online References
<ul>
<li><a href="https://tianpan.co/notes/243-designing-online-judge-or-leetcode">Designing Online Judge or Leetcode</a></li>
<li><a href="https://medium.com/@akashgp09/make-your-own-online-compiler-in-react-%EF%B8%8F-b06bc29dd202">Make your own online compiler in React</a></li>
<li><a href="https://youtu.be/mq18_oSNkHE?t=966">Programski jezik Go - FER 2019./2020. - Prvo predavanje</a></li>
<li><a href="https://web.archive.org/web/20220527143632/https://www.fer.unizg.hr/novosti?%40=2utqx">Sudjelovanje FER-a na Smotri Sveučilišta 2019.</a></li>
<li><a href="https://web.archive.org/web/20220527143506/https://www.fer.unizg.hr/novosti?%40=2utg3">Svečana 672. sjednica Fakultetskog vijeća FER-a</a></li>
<li><a href="https://usaco.guide/general/running-code-online">USACO Guide - Running Code Online</a></li>
<li><a href="https://repozitorij.fer.unizg.hr/en/islandora/object/fer%3A3607">Web application for authoring and sharing code snippets in different programming languages
</a></li>
<li><a href="https://medium.com/javarevisited/lets-deploy-our-online-code-executor-in-google-cloud-e76a9fabac57">Let’s Deploy our Online Code Executor in Google Cloud</a></li>
<li><a href="https://levelup.gitconnected.com/lets-develop-an-online-code-editor-compiler-like-hackerrank-c433d8db060d">Let’s Develop an Online Code Editor & Compiler like HackerRank</a></li>
<li><a href="https://medium.com/javascript-in-plain-english/lets-develop-an-online-code-editor-compiler-like-hackerrank-702881803eee">Let’s Develop An Online Code Editor/Compiler Like HackerRank</a></li>
<li><a href="https://www.youtube.com/watch?v=AruJ23XlBps">Build a Live Code Editor & Playground like HackerRank Using Vue</a></li>
<li><a href="https://geekflare.com/top-java-ide-and-online-compilers">Top 11 Java IDEs and Online Compilers for Productive Development</a></li>
<li><a href="https://www.freecodecamp.org/news/how-to-build-react-based-code-editor/">How to Build a Code Editor with React that Compiles and Executes in 40+ Languages</a></li>
<li><a href="https://medium.com/javarevisited/how-to-build-an-online-java-compiler-c3210cca1917">How to Build an Online Java Compiler</a></li>
<li><a href="https://www.fossguru.com/best-cloud-ide-review/">Top 33 Best Cloud IDE For The Developers (2022 Review)</a></li>
<li><a href="https://geekflare.com/productivity-apps-for-programmers/">21 Productivity Apps for Programmers</a></li>
<li><a href="https://manfonly.medium.com/running-sqlite-on-the-browser-45c5a7352fd">Running sqlite on the browser</a></li>
<li><a href="https://medium.com/@denishoti/how-to-self-host-judge0-api-on-your-pc-locally-all-you-need-to-know-ad8a2b64fd1">How to self-host Judge0 API on your PC locally | All you need to know</a></li>
<li><a href="https://blog.ishandeveloper.com/hackerrank">Summer Internship Experience '21</a></li>
<li><a href="https://dev.to/envoy_/best-websites-every-programmer-should-visit-540a">Best Websites Every Programmer Should Visit</a></li>
<li><a href="https://cssauthor.com/best-online-code-editors/">Excellent Online Code Editors</a></li>
<li><a href="https://medium.com/codingsquad/a-pair-programming-platform-to-help-you-get-better-at-technical-interviews-building-out-the-14c03762ebf4">A pair programming platform to help you get better at technical interviews: building out the platform</a></li>
<li><a href="https://cbrincoveanu.hashnode.dev/10-amazing-free-tools-for-your-blog-posts-and-developer-projects">10 Amazing Free Tools For Your Blog Posts And Developer Projects</a></li>
<li><a href="https://medium.com/the-foss-albatross/the-easiest-way-to-start-coding-30cf99ee039d">The Easiest Way to Start Coding!</a></li>
<li><a href="https://prog.world/how-to-create-a-code-editor-for-40-languages-with-react/">How to create a code editor for 40+ languages ​​with React</a></li>
<li><a href="https://www.youtube.com/watch?v=z1ErJCATLuo">Tutorial isi api key di pc platform</a></li>
<li><a href="https://www.jdoodle.com/blog/guide_choosing_the_best_compiler_api">The ultimate guide to choosing a Compiler API for your workflow</a></li>
<li><a href="https://thelinuxcode.com/how-to-build-a-code-editor-with-react-that-compiles-and-executes-in-40-languages/">How to Build a Code Editor with React that Compiles and Executes in 40+ Languages</a></li>
<li><a href="https://devpost.com/software/litcode">LitCode</a></li>
<li><a href="https://tantosec.com/blog/judge0/">Judge0 Sandbox Escape</a></li>
<li><a href="https://kibichomurage.medium.com/building-a-leetcode-clone-backend-462fa1084aa5">Building a Leetcode clone backend</a></li>
<li><a href="https://hackmd.io/@hIUpwGqPS4asgJ4ccgfoMw/SJ3ClK63K">Deployment on Google Cloud</a></li>
<li><a href="https://dev.to/nilmadhabmondal/let-s-deploy-our-online-code-executor-in-google-cloud-41b0">Let’s Deploy our Online Code Executor in Google Cloud</a></li>
<li><a href="https://github.com/MelloB1989/judge0.k8s">Judge0 on AKS Cluster Setup</a></li>
<li><a href="https://integratedcybersecurity.ai/excellent-online-code-editors/">Excellent Online Code Editors</a></li>
<li><a href="https://scriptedsynapses.substack.com/p/weak-control">Weak Control - Measuring the performance gap in Trusted Editing</a></li>
<!-- <li><a href=""></a></li> -->
</ul>

## Showcase
These open-source projects are using Judge0. You can add yours as well by creating a PR.

* [LeetCode clone by Kartik Joshi](https://github.com/kdj309/leetcode-clone)
* [Competitive Coding Portal by CodeChefVIT](https://github.com/CodeChefVIT/cookoff-9.0-backend)
* [Codeforces Lite by Maanas Sehgal](https://github.com/MaanasSehgal/Codeforces-Lite)

## Citation
Please [cite us](https://ieeexplore.ieee.org/abstract/document/9245310) if you found the resources in this repository useful.

```bibtex
@INPROCEEDINGS{9245310,
  author={Došilović, Herman Zvonimir and Mekterović, Igor},
  booktitle={2020 43rd International Convention on Information, Communication and Electronic Technology (MIPRO)},
  title={Robust and Scalable Online Code Execution System},
  year={2020},
  volume={},
  number={},
  pages={1627-1632},
  keywords={Production systems;Operating systems;Systems architecture;Computer architecture;Programming profession;Open source software;Recruitment;online code execution system;online judge system;untrusted code execution},
  doi={10.23919/MIPRO48935.2020.9245310}
}
```

## Community
Do you have a question, feature request, or something else on your mind? Or do you want to follow Judge0 news?

* [Subscribe to Judge0 newsletter](https://subscribe.judge0.com)
* [Join our Discord server](https://discord.gg/GRc3v6n)
* [Watch asciicasts](https://asciinema.org/~hermanzdosilovic)
* [Report an issue](https://github.com/judge0/judge0/issues/new)
* [Contact us](mailto:contact@judge0.com)
* [Schedule an online meeting with us](https://meet.judge0.com)

## Author and Contributors
Judge0 was created and is maintained by [Herman Zvonimir Došilović](https://hermanz.dosilovic.com).

Thanks to all [contributors](https://github.com/judge0/judge0/graphs/contributors) for contributing to this project.

<a href="https://github.com/judge0/judge0/graphs/contributors">
  <img src="https://contributors-img.web.app/image?repo=judge0/judge0" />
</a>

## Changelog
You can find the detailed specification of changes between versions in [CHANGELOG.md](CHANGELOG.md).

## Special Thanks
Special thanks to open-source projects without whom Judge0 probably wouldn't exist: [Isolate](https://github.com/ioi/isolate), [Docker](https://github.com/docker), [Ruby on Rails](https://github.com/rails/rails) and others.

## License
Judge0 is licensed under the [GNU General Public License v3.0](LICENSE).
