# this should be used to store unsupported languages
# a new column should be added to the languages table: is_unsupported:boolean default:false
# unsupported languages should have is_unsupported set to true
# unsupported languages should not be returned by default in the languages list API
# unsupported languages should not be allowed in new submissions
# existing submissions with unsupported languages should still work

@languages ||= []
@languages +=
[
  {
    id: 45,
    name: "Assembly (NASM 2.14.02)",
    source_file: "main.asm",
    compile_cmd: "/usr/local/nasm-2.14.02/bin/nasmld -f elf64 %s main.asm",
    run_cmd: "./a.out"
  },
    {
    id: 47,
    name: "Basic (FBC 1.07.1)",
    source_file: "main.bas",
    compile_cmd: "/usr/local/fbc-1.07.1/bin/fbc %s main.bas",
    run_cmd: "./main"
  },
  {
    id: 56,
    name: "D (DMD 2.089.1)",
    source_file: "main.d",
    compile_cmd: "/usr/local/d-2.089.1/linux/bin64/dmd %s main.d",
    run_cmd: "./main"
  },
    {
    id: 83,
    name: "Swift (5.2.3)",
    source_file: "Main.swift",
    compile_cmd: "/usr/local/swift-5.2.3/bin/swiftc %s Main.swift",
    run_cmd: "./Main"
  },
  {
    id: 84,
    name: "Visual Basic.Net (vbnc 0.0.0.5943)",
    source_file: "Main.vb",
    compile_cmd: "/usr/bin/vbnc %s Main.vb",
    run_cmd: "/usr/bin/mono Main.exe"
  },
    {
    id: 86,
    name: "Clojure (1.10.1)",
    source_file: "main.clj",
    run_cmd: "/usr/local/bin/java -jar /usr/local/clojure-1.10.1/clojure.jar main.clj"
  },
  {
    id: 69,
    name: "Prolog (GNU Prolog 1.4.5)",
    source_file: "main.pro",
    compile_cmd: "PATH=\"/usr/local/gprolog-1.4.5/gprolog-1.4.5/bin:$PATH\" /usr/local/gprolog-1.4.5/gprolog-1.4.5/bin/gplc --no-top-level %s main.pro",
    run_cmd: "./main"
  },
]