@languages ||= []
@languages +=
[
  {
    id: 48,
    name: "C (GCC 7.4.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-7.4.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 49,
    name: "C (GCC 8.3.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-8.3.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 50,
    name: "C (GCC 9.2.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 51,
    name: "C# (Mono 6.6.0.161)",
    is_archived: false,
    source_file: "Main.cs",
    compile_cmd: "/usr/local/mono-6.6.0.161/bin/mcs %s Main.cs",
    run_cmd: "/usr/local/mono-6.6.0.161/bin/mono Main.exe"
  },
  {
    id: 52,
    name: "C++ (GCC 7.4.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-7.4.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-7.4.0/lib64 ./a.out"
  },
  {
    id: 53,
    name: "C++ (GCC 8.3.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-8.3.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-8.3.0/lib64 ./a.out"
  },
  {
    id: 54,
    name: "C++ (GCC 9.2.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out"
  },
  
  {
    id: 63,
    name: "JavaScript (Node.js 12.14.0)",
    is_archived: false,
    source_file: "script.js",
    run_cmd: "/usr/local/node-12.14.0/bin/node script.js"
  },



  {
    id: 70,
    name: "Python (2.7.17)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/local/python-2.7.17/bin/python2 script.py"
  },
  {
    id: 71,
    name: "Python (3.8.1)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/local/python-3.8.1/bin/python3 script.py"
  },
  {
    id: 72,
    name: "Ruby (2.7.0)",
    is_archived: false,
    source_file: "script.rb",
    run_cmd: "/usr/local/ruby-2.7.0/bin/ruby script.rb"
  },


  {
    id: 75,
    name: "C (Clang 7.0.1)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/clang-7 %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 76,
    name: "C++ (Clang 7.0.1)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/clang++-7 %s main.cpp",
    run_cmd: "./a.out"
  },

  {
    id: 78,
    name: "Kotlin (1.3.70)",
    is_archived: false,
    source_file: "Main.kt",
    compile_cmd: "/usr/local/kotlin-1.3.70/bin/kotlinc %s Main.kt",
    run_cmd: "/usr/local/kotlin-1.3.70/bin/kotlin MainKt"
  },
 
]