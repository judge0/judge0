[![Judge0 Wallpaper](./.github/Judge0%20Wallpaper%2002%20Center%20White%208192x4608.png)](https://judge0.com)

# Judge0
[![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/Judge0HQ)](https://x.com/Judge0HQ)
[![X (formerly Twitter) Follow](https://img.shields.io/twitter/follow/hermanzvonimir)](https://x.com/hermanzvonimir)

[![License](https://img.shields.io/github/license/judge0/judge0?color=2185d0&style=flat-square)](LICENSE)
[![Release](https://img.shields.io/github/v/release/judge0/judge0?color=2185d0&style=flat-square)](https://github.com/judge0/judge0/releases)
[![Stars](https://img.shields.io/github/stars/judge0/judge0?color=2185d0&style=flat-square)](https://github.com/judge0/judge0/stargazers)

Established in August 2016.

Code execution made simple for every business.

Robust, fast, scalable, and sandboxed open-source online code execution system for humans and AI.

## Table of Contents

* [About](#about)
* [Features](#features)
* [Get Started](#get-started)
* [Flavors](#flavors)
* [Citation](#citation)
* [References](#references)
* [Showcase](#showcase)
* [Community](#community)
* [Author and Contributors](#author-and-contributors)
* [Changelog](#changelog)
* [Special Thanks](#special-thanks)
* [License](#license)

## About

[Judge0](https://judge0.com) (pronounced like "judge zero") is a robust, scalable, and [open-source](https://github.com/judge0/judge0) **online code execution system**. You can use it to build a wide range of applications that need online code execution features. Some examples include AI agents, competitive programming platforms, e-learning platforms, candidate assessment and recruitment platforms, online code editors, online IDEs, and many more.

Judge0 is an open-source online code execution system that enables the robust, fast, scalable, and sandboxed execution of AI-generated code, with support for multiple languages and frameworks.

In our research paper [Robust and Scalable Online Code Execution System](https://paper.judge0.com), we present Judge0's modern modular architecture that can be easily deployed and scaled. We study its design, comment on the various challenges in building such systems, and compare it with other available online code execution systems and online judge systems.

To see Judge0 in action, try [Judge0 IDE](https://ide.judge0.com) - our free and open-source online code editor.

## Features

* [Self-hostable](https://github.com/judge0/judge0/blob/master/CHANGELOG.md#deployment-procedure) or [fully managed (SaaS)](https://judge0.com#pricing)
* Quick and easy self-hosting [installation](https://github.com/judge0/judge0/blob/master/CHANGELOG.md#deployment-procedure)
* Rich and verbose [API documentation](https://ce.judge0.com)
* Simple HTTP JSON API for easy integration
* [Official Python SDK](https://github.com/judge0/judge0-python) for easy integration
* Scalable architecture for handling high loads
* Sandboxed compilation and execution of untrusted code
* Support for 90+ languages (see the full [list of supported languages](https://ide.judge0.com))
* Compilation and execution of multi-file programs (i.e. projects)
* Support for additional files alongside the single-file user's program
* Support for custom user-defined compiler options, command-line arguments, and time and memory limits
* Detailed execution results
* Webhooks (HTTP callbacks)

For more information about these and other features, please [read the documentation](https://ce.judge0.com).

## Get Started

You have plenty of options to get started with Judge0:
1. [Use our Judge0 Cloud via Rapid](https://rapidapi.com/organization/judge0)
2. [Use our Judge0 Cloud by directly working with us](https://judge0.com/#pricing)
3. [Self-host Judge0 on your own infrastructure](https://github.com/judge0/judge0/blob/master/CHANGELOG.md#deployment-procedure)

Integrating Judge0 into your application is easy. You can either use our simple HTTP JSON API or use our [official Python SDK](https://github.com/judge0/judge0-python).

### HTTP JSON API
```bash
curl \
  -H "Content-Type: application/json" \
  -d '{
      "language_id": 109,
      "source_code": "print(f\"hello, {input()}\")",
      "stdin": "Alice"
  }' \
  "https://ce.judge0.com/submissions?wait=true"
```

### Python SDK
```python
# pip install judge0
import judge0
result = judge0.run(source_code="print(f'hello, {input()}')", stdin="Alice", language=judge0.PYTHON)
print(result.stdout)
```

## Flavors

Judge0 comes in two flavors: [Judge0 CE](https://rapidapi.com/judge0-official/api/judge0-ce) and [Judge0 Extra CE](https://rapidapi.com/judge0-official/api/judge0-extra-ce). They differ mostly in the supported languages.

You can find the source code for Judge0 CE on the `master` branch, while you can find the source code for Judge0 Extra CE on the `extra` branch.

## Citation

Please [cite us](https://ieeexplore.ieee.org/abstract/document/9245310) if you use Judge0 in your research:

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

## References

### Industry

[These companies, institutions, and organizations use Judge0.](https://judge0.com)

### Academia

These scientific articles cite Judge0.

* [«SYNCODING» - COLLABORATIVE CODE WRITING](https://ikee.lib.auth.gr/record/359400)
* [A comparison between online compilers: A Case Study](https://ieeexplore.ieee.org/document/9797096/)
* [A Game-Changing Instructor Tool to Reinforce Coding Concepts](https://dl.acm.org/doi/10.1145/3328778.3372610)
* [A ML-Based Stock Trading Model for Profit Predication](https://www.researchgate.net/publication/353328644_A_ML-Based_Stock_Trading_Model_for_Profit_Predication)
* [A Secure and Scalable System for Online Code Execution and Evaluation using Containerization and Kubernetes](https://www.jetir.org/papers/JETIR2302226.pdf)
* [A Secure, Scalable, and Integrated Smart Platform for Teaching and Coding](https://www.taylorfrancis.com/chapters/edit/10.1201/9781032673479-20/secure-scalable-integrated-smart-platform-teaching-coding-mohit-dua-giri-sainath-reddy-ramesh-vishnoi-satyam-tomar-shelza-dua)
* [A Strategy Based on Technological Maps for the Identification of the State-of-the-Art Techniques in Software Development Projects: Virtual Judge Projects as a Case Study](https://link.springer.com/chapter/10.1007/978-3-319-98998-3_27)
* [A Survey of Vibe Coding with Large Language Models](https://arxiv.org/abs/2510.12399)
* [ADAPTIVE MENTORING WITH IMMEDIATE FEEDBACK FOR THE DEVELOPMENT OF PROGRAMMING SKILLS](https://library.iated.org/view/PEREZROJAS2024ADA)
* [Advanced lab analysis system using apache spark](https://pubs.aip.org/aip/acp/article/2492/1/030016/2892049)
* [AI-Powered Code Evaluation and Learning Assessment Platform](https://www.researchgate.net/publication/400479340_AI-Powered_Code_Evaluation_and_Learning_Assessment_Platform)
* [An Online Judge System in Learning Management System](https://books.google.hr/books?id=KxyLEQAAQBAJ&lpg=PA327&ots=f0nMFB8KtH&lr=lang_en&pg=PA327#v=onepage&q&f=false)
* [Analiza performansi sustava za udaljeno izvršavanje programskog kôda](https://repozitorij.fer.unizg.hr/islandora/object/fer%3A7913)
* [Arena Acadnet - An Educational Platform for Practicing and Solving Coding Challenges](https://www.researchgate.net/publication/397088048_Arena_Acadnet_-_An_Educational_Platform_for_Practicing_and_Solving_Coding_Challenges)
* [Artificial Intelligence and Computer-Supported Collaborative Learning in Programming: A Systematic Mapping Study](http://ref.scielo.org/bmd4hy)
* [Automatic Evaluation of Student Software Solutions in a Virtualized Environment](https://ieeexplore.ieee.org/document/10159927)
* [Automatic marking system for programming subject](http://eprints.utar.edu.my/5990/)
* [Automatic question generation for JavaScript programming courses](https://ntnuopen.ntnu.no/ntnu-xmlui/handle/11250/3088497)
* [Big Data based Advanced Lab Analysis System using Apache Spark](https://ieeexplore.ieee.org/abstract/document/9489186)
* [Bridging code and timely feedback: integrating generative AI into a programming platform](https://peerj.com/articles/cs-3070/)
* [Building a Comprehensive Automated Programming Assessment System](https://ieeexplore.ieee.org/document/9079865)
* [Canvas Coding: una piattaforma di gioco per studenti basata sulla programmazione creativa = Canvas Coding: a gaming platform for students based on creative programming](https://webthesis.biblio.polito.it/29496/)
* [Code Master: A Web-Based Competitive Programming Practice Platform](https://www.ijsreat.com/archiver/archives/code_master_a_web_based_competitive_programming_practice_platform.pdf)
* [Code Verse](https://www.researchgate.net/publication/381988455_Code_Verse)
* [CodeCoach: An Interactive ProgrammingAssistance Tool](https://www.researchgate.net/publication/376610279_CodeCoach_An_Interactive_ProgrammingAssistance_Tool)
* [CODEGEEK: A NEXT-GENERATION CODING PLATFORM WITH AI- DRIVEN FEEDBACK](https://elibrary.ru/item.asp?id=82002080)
* [CODEGEN: A React-Based Online Coding Workspace with Advanced Features and Real-Time Execution](https://www.researchgate.net/publication/386243931_CODEGEN_A_React-Based_Online_Coding_Workspace_with_Advanced_Features_and_Real-Time_Execution)
* [Computing students’ design preferences and barriers when solving short programming problems](https://peer.asee.org/computing-students-design-preferences-and-barriers-when-solving-short-programming-problems)
* [Creating a Platform for Competitive Programming Training with Integration of Automatic Decision Checking System](https://www.researchgate.net/publication/391464412_Creating_a_Platform_for_Competitive_Programming_Training_with_Integration_of_Automatic_Decision_Checking_System)
* [CURIOSMAZE: plataforma web educativa diseñada como herramienta de refuerzo para evaluar el pensamiento lógico y las competencias en programación, utilizando Judge0 como sistema de ejecución de código, para la Unidad Educativa Juan Pablo II](https://repositorio.puce.edu.ec/items/da89d5a6-6485-4cb9-b87d-e1fd236043f3)
* [Data science in Java/JavaScript programming environment for AI-assisted programming](https://dr.ntu.edu.sg/entities/publication/98e3138a-c5e5-4b11-a3d0-fa6cab679d67)
* [Dataset for Validation and Performance Testing of Online Judges](https://revistas.setrem.com.br/index.php/reabtic/article/view/462/225)
* [Desarrollo de una plataforma orientada al refuerzo en la evaluación del nivel de programación](https://oa.upm.es/63124/)
* [Desenvolvimento de um software Web para auxiliar o processo de ensino-aprendizagem da disciplina de Introdução à Ciência da Computação (ICC) da UNESP - Instituto de Ciência e Tecnologia de Sorocaba](https://repositorio.unesp.br/items/145d27dd-354b-45ee-b465-ef9e9b25d03f)
* [Design and Implementation of a Real-Time Feedback System for Enhancing College-Level Coding Proficiency](https://isjem.com/download/design-and-implementation-of-a-real-time-feedback-system-for-enhancing-college-level-coding-proficiency-2/)
* [DESIGN-BASED DEVELOPMENT OF A MULTI-TYPE QUIZ AUTHORING TOOL FOR ACTIVE LEARNING](https://library.iated.org/view/PHAM2025DES)
* [Designing a Platform to Train Secure Programming Skills With Attack-and-Defend Exercises](https://people.cs.vt.edu/tilevich/papers/educon2025.pdf)
* [Development of a System for Automated Testing of Program Code for the Educational Process in the Discipline "Programming Languages](https://geosib.sgugit.ru/upload/geosibir/sborniki/2023/tom-7-1/164-171.pdf)
* [ECCO: Can We Improve Model-Generated Code Efficiency Without Sacrificing Functional Correctness?](https://arxiv.org/abs/2407.14044)
* [Evaluation of an Online Judge for Concurrent Programming Learning](https://ieeexplore.ieee.org/abstract/document/10346201)
* [Exploiter le Language Server Protocol pour créer un éditeur de code nomade et ergonomique](https://pure.unamur.be/ws/portalfiles/portal/98847091/2024_LoirS_Memoire.pdf)
* [Exploring Automated Code Evaluation Systems and Resources for Code Analysis: A Comprehensive Survey](https://arxiv.org/abs/2307.08705)
* [Full-stack web development for auto-assessment platform](https://dr.ntu.edu.sg/handle/10356/162927)
* [Future-Proofing Programmers: Optimal Knowledge Tracing for AI-Assisted Personalized Education](https://arxiv.org/abs/2509.23996)
* [Grid-Coding: An Accessible, Efficient, and Structured Coding Paradigm for Blind and Low-Vision Programmers](https://dl.acm.org/doi/abs/10.1145/3526113.3545620)
* [JediCode -- A Gamefied Approach to Competitive Coding](https://arxiv.org/abs/2311.10244)
* [KOA: An AI-Integrated Productivity Intelligence Platform for Coding Skill Development and Real-Time Performance Analytics](https://www.researchgate.net/publication/399160152_KOA_An_AI-Integrated_Productivity_Intelligence_Platform_for_Coding_Skill_Development_and_Real-Time_Performance_Analytics)
* [Large Language Models in der Berufsausbildung von IT-Fachkräften]()
* [Learn To Code Fast](https://www.ijert.org/learn-to-code-fast)
* [MAGECODE: Machine-Generated Code Detection Method Using Large Language Models](https://ieeexplore.ieee.org/abstract/document/10772217)
* [Modul za obavljanje korisnički definiranih programa u sustavu za automatsko ocjenjivanje programskog kôda Edgar](https://repozitorij.fer.unizg.hr/en/islandora/object/fer%3A12816)
* [Nacionalni repozitorij završnih i diplomskih radova ZIR](https://zir.nsk.hr/islandora/search/dabar_search_keywords_mt:(%22Judge0%22))
* [NEOLEARN: AI – DRIVEN SYSTEM FOR STUDENT ASSESSMENT AND ADAPTIVE LEARNING](https://www.irjmets.com/upload_newfiles/irjmets71200034667/paper_file/irjmets71200034667.pdf)
* [Online Automatic Assessment System for Program Code: Architecture and Experiences](https://www.researchgate.net/publication/353329318_Online_Automatic_Assessment_System_for_Program_Code_Architecture_and_Experiences)
* [Online Judge System: Requirements, Architecture, and Experiences](https://www.worldscientific.com/doi/10.1142/S0218194022500346)
* [PEERLINK: A Comprehensive Collaborative Platform](https://ijsrset.com/index.php/home/article/view/IJSRSET25122209)
* [Pengembangan Sistem Manajemen Evaluasi Pembelajaran Terintegrasi Dengan Online Judge](https://journals.upi-yai.ac.id/index.php/ikraith-informatika/article/view/1405)
* [PERSSISTANT: A Progress Estimation System to Personalize Learning Trajectories](https://documentserver.uhasselt.be/handle/1942/44162)
* [Predviđanje uspjeha studenata u sustavu za automatsko ocjenjivanje programskog kôda Edgar](https://repozitorij.unizg.hr/islandora/object/fer:12103)
* [Programmable Questions in Edgar](https://ieeexplore.ieee.org/abstract/document/10159897)
* [Prototip integracije sustava za strojno učenje u sustav Edgar](https://repozitorij.fer.unizg.hr/islandora/object/fer%3A10234)
* [Protótipo de uma ferramenta gamificada para a aplicação de atividades práticas em sala de aula em uma disciplina de introdução à programação](http://repositorio.uft.edu.br/handle/11612/3789)
* [Rancang Bangun Sistem Online Judge dan Pendeteksian Plagiarisme Menggunakan Arsitektur Serverless](https://journal.unesa.ac.id/index.php/jieet/article/view/8363)
* [Real Time Code Collaboration and Interview Platform](https://ijsrset.com/index.php/home/article/view/IJSRSET2513849/IJSRSET2513849)
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
* [Видеомессенджер для совместной работой над кодом](https://elar.urfu.ru/handle/10995/135781)
* [Платформа для спільної роботи викладача та студента під час іспиту](https://ela.kpi.ua/handle/123456789/31297)
* [ПОЯСНЮВАЛЬНА ЗАПИСКА ДО БАКАЛАВРСЬКОЇ РОБОТИ на тему ТРЕНАЖЕР З ТЕМИ «ПОБУДОВА БЛОК-СХЕМ АЛГОРИТМІВ ЦИКЛІЧНОЇ СТРУКТУРИ НА ПРИКЛАДІ ЦИКЛУ WHILE» ДИСТАНЦІЙНОГО НАВЧАЛЬНОГО КУРСУ «ПРОГРАМУВАННЯ ІІ» ТА РОЗРОБКА ЙОГО ПРОГРАМНОГО ЗАБЕЗПЕЧЕННЯ](http://dspace.puet.edu.ua/handle/123456789/11371)
* [Розробка структури та програмна реалізація інтерфейсу WEB-редактора](http://dp.knute.edu.ua/jspui/bitstream/123456789/8142/1/%D0%92%D0%9A%D0%A0_%D0%9A%D0%BE%D0%B2%D1%82%D1%83%D0%BD_%D0%A4%D0%86%D0%A2%20%204-10.pdf)

### Other Online References

* [10 Amazing Free Tools For Your Blog Posts And Developer Projects](https://cbrincoveanu.hashnode.dev/10-amazing-free-tools-for-your-blog-posts-and-developer-projects)
* [21 Productivity Apps for Programmers](https://geekflare.com/productivity-apps-for-programmers/)
* [A pair programming platform to help you get better at technical interviews: building out the platform](https://medium.com/codingsquad/a-pair-programming-platform-to-help-you-get-better-at-technical-interviews-building-out-the-14c03762ebf4)
* [AI Cheating in Coding Interviews: Rounds' Anti-Cheat Solution](https://judge0.com/blog/ai-cheating-in-coding-interviews-rounds-anti-cheat-solution)
* [AI Code editor - Judge0 + Chatbot](https://www.youtube.com/watch?v=2EW6mHsxVhA)
* [AI Code Editor - Judge0 Integration | AI-Powered Coding Experience](https://www.youtube.com/watch?v=INFFmvbVkbQ)
* [AI Code Editor](https://www.youtube.com/watch?v=E0zB9aBJ-tw)
* [AI Code Editor](https://www.youtube.com/watch?v=mXIXKoOXcNQ)
* [AI Craft IDE - The Future of AI-Powered Coding & Debugging! 🔥](https://www.youtube.com/watch?v=ZEqAhNko-HY)
* [Best Websites Every Programmer Should Visit](https://dev.to/envoy_/best-websites-every-programmer-should-visit-540a)
* [Build a Live Code Editor & Playground like HackerRank Using Vue](https://www.youtube.com/watch?v=AruJ23XlBps)
* [Build an Online Code Compiler with Next.js 15 (JavaScript, Python, C++, Java, more..) Source Code](https://www.youtube.com/watch?v=oziCi_5aYsk)
* [Build Your Own Code Editor using React, CodeMirror and Judge0 | Unique React API Project I AccioJob](https://www.youtube.com/watch?v=Tg4_Zyyx-QA)
* [Build your own LeetCode | Online Code Execution Engiene | Judge0](https://www.youtube.com/watch?v=uOlP7njiaCg)
* [Build Your Own LeetCode-Style Coding Platform with ⚡ Angular 19 & 🔥 Judge0](https://medium.com/@joshnah/build-your-own-leetcode-style-coding-platform-with-angular-19-judge0-a5b1107b71a4)
* [Build, Automate and Deploy a LeetCode Clone | MERN](https://www.youtube.com/playlist?list=PL5LqTNtiVovVWED7HpQ0Jj6VEQqgRRJUX)
* [Building a Leetcode clone backend](https://kibichomurage.medium.com/building-a-leetcode-clone-backend-462fa1084aa5)
* [Building CodeNova: System Design Deep Dive into an AI-Enhanced Coding Platform](https://dev.to/bchikara/building-codenova-system-design-deep-dive-into-an-ai-enhanced-coding-platform-11d4)
* [C Code Runner with Monaco Editor | Judge0 API Integration Fetching Github repo](https://www.youtube.com/watch?v=OIfhZ5gA_L0)
* [Code Execution in Kestra’s AI Agents Powered by Judge0](https://judge0.com/blog/code-execution-in-kestras-ai-agents-powered-by-judge0)
* [CodeAIDE Walkthrough | Online AI IDE Project](https://www.youtube.com/watch?v=Z7fe3DVCqWo)
* [CodeX | IDE + AI | Judge0 | OpenRouter | Tailwind CSS](https://www.youtube.com/watch?v=VLwhqqEm2L8)
* [Deployment on Google Cloud](https://hackmd.io/@hIUpwGqPS4asgJ4ccgfoMw/SJ3ClK63K)
* [Designing a Race-ready Backend for our Competitive coding portal with Golang, Echo & Redis : Part one](https://blogs.codechefvit.com/pitlane-to-production-p1)
* [Designing Online Judge or Leetcode](https://tianpan.co/notes/243-designing-online-judge-or-leetcode)
* [Excellent Online Code Editors](https://cssauthor.com/best-online-code-editors/)
* [Excellent Online Code Editors](https://integratedcybersecurity.ai/excellent-online-code-editors/)
* [Exploiting Symlinks: A Deep Dive into CVE-2024–28185 and CVE-2024–28189 of Judge0 Sandboxes](https://infosecwriteups.com/exploiting-symlinks-a-deep-dive-into-cve-2024-28185-and-cve-2024-28189-of-judge0-sandboxes-36bd471cfc4d)
* [From Zero to Production: Building a Feishu AI Assistant with Clawdbot on AWS EC2](https://www.linkedin.com/pulse/from-zero-production-building-feishu-ai-assistant-clawdbot-zhang-r8oye/)
* [Go Playground MCP Server: The Ultimate Guide for AI Engineers](https://skywork.ai/skypage/en/go-playground-mcp-server-ai-engineers-guide/1981583589895106560)
* [How code execution works in OpenLearning platform](https://web.archive.org/web/20260205095342/https://code-execution.openlearning.com/)
* [How I Built a Code Judge That Serves 1M+ Users](https://web.archive.org/web/20260201131823/https://www.linkedin.com/posts/neetcodeio_%F0%9D%97%9B%F0%9D%97%BC%F0%9D%98%84-%F0%9D%97%9C-%F0%9D%97%95%F0%9D%98%82%F0%9D%97%B6%F0%9D%97%B9%F0%9D%98%81-%F0%9D%97%AE-%F0%9D%97%96%F0%9D%97%BC%F0%9D%97%B1%F0%9D%97%B2-%F0%9D%97%9D%F0%9D%98%82%F0%9D%97%B1%F0%9D%97%B4-activity-7323003422079700992-GV3l)
* [How I fully compromised the “most advanced code execution system in the world”, Daniel Cooper](https://www.youtube.com/watch?v=aW-w0c3v7Mw)
* [How to Build a Code Editor with React that Compiles and Executes in 40+ Languages](https://thelinuxcode.com/how-to-build-a-code-editor-with-react-that-compiles-and-executes-in-40-languages/)
* [How to Build a Code Editor with React that Compiles and Executes in 40+ Languages](https://www.freecodecamp.org/news/how-to-build-react-based-code-editor/)
* [How to build an online compiler! RCE - remote code execution engine](https://www.youtube.com/watch?v=Cm2J9ew8oVw)
* [How to Build an Online Java Compiler](https://medium.com/javarevisited/how-to-build-an-online-java-compiler-c3210cca1917)
* [How to Choose the Right Server Based on Your Application](https://polygontechnology.io/how-to-choose-the-right-server-for-your-application)
* [How to create a code editor for 40+ languages ​​with React](https://prog.world/how-to-create-a-code-editor-for-40-languages-with-react/)
* [How to deploy judge0 compiler on AWS EC2 | Deploying compiler engine | Judge0 CE](https://www.youtube.com/watch?v=lw1XCvHEO6Y)
* [How to Install Judge0 on WSL and Linux – Step-by-Step Guide for Developers](https://www.youtube.com/watch?v=mvNgqrx2cfA)
* [How to self-host Judge0 API on your PC locally | All you need to know](https://medium.com/@denishoti/how-to-self-host-judge0-api-on-your-pc-locally-all-you-need-to-know-ad8a2b64fd1)
* [How we designed a code evaluation pipeline using Judge0 with Golang, Echo & Redis.](https://blogs.codechefvit.com/pitlane-to-production-p2)
* [I Built a Real-Time 1v1 Coding Battle Platform in Days Using Kiro](https://dev.to/aieradev/i-built-a-real-time-1v1-coding-battle-platform-in-days-using-kiro-25de)
* [I coded Codeforces.com in under 4 hours](https://www.youtube.com/watch?v=vABb1y4fmwE)
* [Implementation Documentation: Judge0 in Frontend Projects](https://medium.com/@victor.c.okoye/implementation-documentation-judge0-in-frontend-projects-58a14a68e3fa)
* [In a Defense of Reinventing the Wheel: Coding to Stay Sane in a Legacy Hell](https://frombadge.medium.com/in-a-defense-of-reinventing-the-wheel-coding-to-stay-sane-in-a-legacy-hell-3c7e0b7e585b)
* [Installing Judge0 in MacOS(Silicon)](https://karan5772.hashnode.dev/installing-judge0-in-macossilicon)
* [Interactive Shell Demonstration Video | Get instant terminals and IDE | interactiveshell.com](https://www.youtube.com/watch?v=bCQtK70ovmM)
* [Introducing AI Agents: Autonomous Orchestration with Declarative Workflows](https://kestra.io/blogs/introducing-ai-agents)
* [Introducing Feenyx: Technical Skill Assessments that Feel Like Real Work](https://judge0.com/blog/introducing-feenyx-technical-skill-assessments-that-feel-like-real-work)
* [Judge0 • Online Code Execution System • Synchronous & Asynchronous Code Execution Demo](https://www.youtube.com/watch?v=jCu5pUYMih0)
* [Judge0 CE on Exit-Saas.io](https://exit-saas.io/alternatives/judge0-ce)
* [Judge0 Code Execution MCP Server: Your AI Agent's New Superpower](https://skywork.ai/skypage/en/judge0-code-execution-ai-agent/1980518601593573376)
* [Judge0 Deployment on AWS Elastic Beanstalk Linux 2: A Developer’s Lifesaver](https://medium.com/@techrox/judge0-deployment-on-aws-elastic-beanstalk-linux-2-a-developers-lifesaver-3b7aaf4662b8)
* [Judge0 Extension Demo - 1st Project || Headstarter.co || Software engineer in residency](https://www.youtube.com/watch?v=6cewVaYKNyA)
* [Judge0 IDE on Product Hunt](https://www.producthunt.com/products/judge0-ide)
* [Judge0 on AKS Cluster Setup](https://github.com/MelloB1989/judge0.k8s)
* [judge0 on Mac M3 macOS Sequoia](https://girishkr.medium.com/judge0-on-mac-m3-macos-sequoia-26946b85d67c)
* [Judge0 on PeerPush](https://peerpush.net/p/judge0)
* [Judge0 Python API: Online Compiler Judge Sandbox Executions Languages Metrics 2026](https://www.johal.in/judge0-python-api-online-compiler-judge-sandbox-executions-languages-metrics-2026)
* [Judge0 Sandbox Escape](https://tantosec.com/blog/judge0/)
* [Leo: Your 24/7 Mock Coding Interviewer](https://judge0.com/blog/leo-your-24-7-mock-coding-interviewer)
* [Let’s Deploy our Online Code Executor in Google Cloud](https://dev.to/nilmadhabmondal/let-s-deploy-our-online-code-executor-in-google-cloud-41b0)
* [Let’s Deploy our Online Code Executor in Google Cloud](https://medium.com/javarevisited/lets-deploy-our-online-code-executor-in-google-cloud-e76a9fabac57)
* [Let’s Develop an Online Code Editor & Compiler like HackerRank](https://levelup.gitconnected.com/lets-develop-an-online-code-editor-compiler-like-hackerrank-c433d8db060d)
* [Let’s Develop An Online Code Editor/Compiler Like HackerRank](https://medium.com/javascript-in-plain-english/lets-develop-an-online-code-editor-compiler-like-hackerrank-702881803eee)
* [LitCode](https://devpost.com/software/litcode)
* [Make your own online compiler in React](https://medium.com/@akashgp09/make-your-own-online-compiler-in-react-%EF%B8%8F-b06bc29dd202)
* [ML Pub Club #25: The Secret Tool of AI Agents](https://luma.com/lwkmqkut)
* [Online IDE | React | Monaco Editor | Judge0 API | Mini Project](https://www.youtube.com/watch?v=w29FWBRJ-EQ)
* [Programski jezik Go - FER 2019./2020. - Prvo predavanje](https://youtu.be/mq18_oSNkHE?t=966)
* [Running sqlite on the browser](https://manfonly.medium.com/running-sqlite-on-the-browser-45c5a7352fd)
* [Self-Hosting Judge0 from Scratch on Windows 11 (Beginner-Friendly, No Docker Knowledge Required)](https://medium.com/@vanshikakriika/self-hosting-judge0-from-scratch-on-windows-11-beginner-friendly-no-docker-knowledge-required-a8fc93ce0a86)
* [Self-Hosting Judge0: A Step-by-Step Guide Using Amazon EC2, Lambda, and S3](https://tutorialsdojo.com/self-hosting-judge0-a-step-by-step-guide-using-aws-ec2-lambda-and-s3)
* [Setting Up Ubuntu and Judge0 on Windows: A Complete Guide for Developers](https://medium.com/@gauravkmaurya09/setting-up-ubuntu-and-judge0-on-windows-a-complete-guide-for-developers-%EF%B8%8F-45f7e3e8bc0b)
* [SocraticAI: Adding AI capabilities to the Judge0 IDE](https://www.youtube.com/watch?v=98xezoHYNtU)
* [Sudjelovanje FER-a na Smotri Sveučilišta 2019.](https://web.archive.org/web/20220527143632/https://www.fer.unizg.hr/novosti?%40=2utqx)
* [Summer Internship Experience '21](https://blog.ishandeveloper.com/hackerrank)
* [Svečana 672. sjednica Fakultetskog vijeća FER-a](https://web.archive.org/web/20220527143506/https://www.fer.unizg.hr/novosti?%40=2utg3)
* [System Design Interview: Design LeetCode (Online Judge) w/ a Ex-Meta Staff Engineer](https://www.youtube.com/watch?v=1xHADtekTNg)
* [Tech Stack I used to Build neetcode.io](https://www.youtube.com/watch?v=KAYny6V1rB0)
* [The Easiest Way to Start Coding!](https://medium.com/the-foss-albatross/the-easiest-way-to-start-coding-30cf99ee039d)
* [The Judge0 Journey: From Shared API Keys to Production-Ready Code Execution](https://medium.com/@adhyakhilosia13/the-judge0-journey-from-shared-api-keys-to-production-ready-code-execution-7f6b7a81baaa)
* [The ultimate guide to choosing a Compiler API for your workflow](https://www.jdoodle.com/blog/guide_choosing_the_best_compiler_api)
* [Top 11 Java IDEs and Online Compilers for Productive Development](https://geekflare.com/top-java-ide-and-online-compilers)
* [Top 33 Best Cloud IDE For The Developers (2022 Review)](https://www.fossguru.com/best-cloud-ide-review/)
* [Tutorial isi api key di pc platform](https://www.youtube.com/watch?v=z1ErJCATLuo)
* [Tutorial isi api key di pc platform](https://www.youtube.com/watch?v=z1ErJCATLuo)
* [Unleash the Coder Within: Hosting Your Own LeetCode with Judge0!](https://medium.com/@writetoxyte/unleash-the-coder-within-hosting-your-own-leetcode-with-judge0-31009e09aa56)
* [USACO Guide - Running Code Online](https://usaco.guide/general/running-code-online)
* [Virginia Science Olympiad Code Testing Environment Demo](https://www.youtube.com/watch?v=FQ2HTml3WS8)
* [Weak Control - Measuring the performance gap in Trusted Editing](https://scriptedsynapses.substack.com/p/weak-control)
* [Web application for authoring and sharing code snippets in different programming languages](https://repozitorij.fer.unizg.hr/en/islandora/object/fer%3A3607)
* [Why I Stopped Self-Hosting](https://www.youtube.com/watch?v=TkysPcpK0aQ)
* [Your own Leetcode with Deployment](https://www.youtube.com/watch?v=6nkNUDNhSYI)

## Showcase

These open-source projects are using Judge0. You can add yours as well by creating a PR.

* [Official Judge0 IDE by Judge0](https://ide.judge0.com)
* [Official Judge0 Python SDK by Judge0](https://github.com/judge0/judge0-python)
* [AtalJudge by Eli Pedro](https://github.com/elipcs/AtalJudge)
* [Chat completion with AI models (Judge0 as the code execution tool the LLM may use to augment its response) by Kestra](https://kestra.io/plugins/plugin-ai/completion/io.kestra.plugin.ai.completion.chatcompletion)
* [Code Execution service at OpenLearning platform](https://web.archive.org/web/20260205094401/https://help.openlearning.com/t/x2ypb80/post-custom-with-code-execution)
* [Code Training with GRPO by Alibaba ModelScope](https://swift.readthedocs.io/en/v3.10/BestPractices/GRPO-Code-Training.html)
* [Codeforces Lite by Maanas Sehgal](https://github.com/MaanasSehgal/Codeforces-Lite)
* [CodeWarz by Philkhana Sidharth](https://www.youtube.com/watch?v=mAE7Fdyrkgc)
* [Competitive Coding Portal by CodeChefVIT](https://github.com/CodeChefVIT/cookoff-9.0-backend)
* [Deadlock - Competitive Programming Battle Arena by warun7](https://github.com/warun7/deadlock)
* [Dev Arsenal by Akhmad Khudri](https://devpost.com/software/dev-arsenal)
* [DraftCode.io by Rotonda](https://dev.to/mulelur/i-built-draftcodeio-a-modern-open-leetcode-style-platform-for-coding-challenges-p9a)
* [Edura - AI Powered Study & Learning Companion by apurva k](https://devpost.com/software/eduniverse-ai-powered-learning-platform)
* [Judge0 CE MCP Server by BACH-AI-Tools](https://glama.ai/mcp/servers/@BACH-AI-Tools/judge0_ce)
* [Judge0 CE MCP Server by bachstudio via Evanth](https://chat.evanth.io/discover/mcp/bachstudio-bach-judge0_ce)
* [Judge0 CE MCP Server by bachstudio via LobeHub](https://lobehub.com/mcp/bachstudio-bach-judge0_ce)
* [Judge0 MCP Server by javaguru via npmjs](https://www.npmjs.com/package/@javaguru/server-judge0)
* [Judge0 MCP Server by ZefanHu via PulseMCP](https://www.pulsemcp.com/servers/judge0-code-execution)
* [LeetBattles by levelingpotato Ma, Shyam Patel, and Ericeric422](https://devpost.com/software/leetbattles)
* [LeetCode clone by Kartik Joshi](https://github.com/kdj309/leetcode-clone)
* [LibreChat Code Interpreter Bridge for Judge0 by leondape](https://github.com/leondape/librechat-code-interpreter-judge0-bridge)
* [Pomelo by SOSC](https://sosc.org.in/projects/pomelo)
* [PyGuide.ai by Daevik Jain and Jeremy Siu](https://devpost.com/software/pyguide-ai)
* [Robust Design by Joshua](https://robustdesign.io)
* [Slashcoder by Jatin Sahu](https://devpost.com/software/slashcoder)
* [Unofficial Judge0 PHP Client by Xefreh](https://github.com/Xefreh/judge0-php-client)
* [Unofficial Judge0 Python Client by Aaron Walker](https://github.com/vCra/judge0api)
* [Unofficial Judge0 Python Client by Roslovets](https://github.com/Roslovets-Inc/judge0-client)
* [Using Judge0 as Code Execution Engine in LangChain4j](https://docs.langchain4j.dev/integrations/code-execution-engines/judge0)

## Community

Join our community - get help, share feedback, and contribute. Whether you're integrating Judge0, building with the API, or reporting bugs, your participation helps improve the project for everyone.

* [Visit Judge0 website](https://judge0.com)
* [Read Judge0 blog](https://blog.judge0.com)
* [Subscribe to Judge0 newsletter](https://newsletter.judge0.com)
* [Join Judge0 Discord server](https://discord.judge0.com)
* [Follow Judge0 on X](https://x.com/Judge0HQ)
* [Follow Judge0 on LinkedIn](https://www.linkedin.com/company/judge0)
* [Read Judge0 research paper](https://paper.judge0.com)
* [Watch Judge0 asciicasts](https://asciinema.org/~hermanzdosilovic)
* [Report an issue](https://github.com/judge0/judge0/issues/new)
* [Contact Judge0 team via email](mailto:contact@judge0.com)
* [Schedule a meeting with Judge0 team](https://meet.judge0.com)

## Author and Contributors

Judge0 was created by [Herman Zvonimir Došilović](https://hermanz.dosilovic.com) in August 2016.

Thanks to all [contributors](https://github.com/judge0/judge0/graphs/contributors) for contributing to this project.

[![](https://contributors-img.web.app/image?repo=judge0/judge0)](https://github.com/judge0/judge0/graphs/contributors)

## Changelog

You can find the detailed specification of changes between versions in the [CHANGELOG.md](CHANGELOG.md).

## Special Thanks

Special thanks to open-source projects without whom Judge0 wouldn't exist: [Isolate](https://github.com/ioi/isolate), [Docker](https://github.com/docker), and [Ruby on Rails](https://github.com/rails/rails).

## License

Judge0 is licensed under the [GNU General Public License v3.0](LICENSE).
