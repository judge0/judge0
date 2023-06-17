@languages ||= []
@languages +=
[
  {
    id: 100,
    name: "C (GCC 11.3.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 101,
    name: "C++ (GCC 11.3.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "g++ %s main.cpp",
    run_cmd: "./a.out"
  },
  {
    id: 102,
    name: "Java (OpenJDK 1.8.0_362)",
    is_archived: false,
    source_file: "Main.java",
    compile_cmd: "javac %s Main.java",
    run_cmd: "java Main"
  },
  {
    id: 103,
    name: "JavaScript (Node.js 14.21.3)",
    is_archived: false,
    source_file: "script.js",
    run_cmd: "node script.js"
  },
  {
    id: 104,
    name: "Python (3.10.6)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "python3 script.py"
  },
  {
    id: 105,
    name: "Ruby (2.7.0)",
    is_archived: false,
    source_file: "script.rb",
    run_cmd: "ruby script.rb"
  },
  {
    id: 106,
    name: "Go (1.17.2)",
    is_archived: false,
    source_file: "main.go",
    compile_cmd: "go build %s main.go",
    run_cmd: "./main"
  },
  {
    id: 107,
    name: "TypeScript (3.7.4)",
    is_archived: false,
    source_file: "script.ts",
    compile_cmd: "tsc %s script.ts",
    run_cmd: "node script.js"
  },
  {
    id: 108,
    name: "Kotlin (1.8.0)",
    is_archived: false,
    source_file: "Main.kt",
    compile_cmd: "kotlin %s Main.kt",
    run_cmd: "kotlin MainKt"
  },
  {
    id: 109,
    name: "Scala (2.13.10)",
    is_archived: false,
    source_file: "Main.scala",
    compile_cmd: "scalac %s Main.scala",
    run_cmd: "scala Main"
  },
  {
    id: 110,
    name: "SQL (SQLite 3.27.2)",
    is_archived: false,
    source_file: "script.sql",
    run_cmd: "/bin/cat script.sql | sqlite3 db.sqlite"
  },
  {
    id: 111,
    name: "Swift (5.2.3)",
    is_archived: false,
    source_file: "Main.swift",
    compile_cmd: "swiftc %s Main.swift",
    run_cmd: "./Main"
  }
]
