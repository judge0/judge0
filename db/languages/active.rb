@languages ||= []
@languages +=
[
  {
    id: 1,
    name: "C (Clang 10.0.1)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/clang-10 %s main.c",
    run_cmd: "./a.out %s"
  },
  {
    id: 2,
    name: "C++ (Clang 10.0.1)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/clang++-10 %s main.cpp",
    run_cmd: "./a.out %s"
  },
  {
    id: 3,
    name: "C3 (latest)",
    is_archived: false,
    source_file: "main.c3",
    compile_cmd: "/usr/local/c3/c3c %s compile main.c3; /usr/bin/clang-10 main.o",
    run_cmd: "./a.out %s"
  },
  {
    id: 4,
    name: "Java (OpenJDK 14.0.1)",
    is_archived: false,
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk14/bin/javac %s Main.java",
    run_cmd: "/usr/local/openjdk14/bin/java Main %s"
  },
  {
    id: 5,
    name: "Java Test (OpenJDK 14.0.1, JUnit Platform Console Standalone 1.6.2)",
    is_archived: false,
    source_file: "MainTest.java",
    compile_cmd: "/usr/local/openjdk14/bin/javac -cp /usr/local/junit-platform-console-standalone-1.6.2/launcher.jar %s MainTest.java",
    run_cmd: "/usr/local/openjdk14/bin/java -jar /usr/local/junit-platform-console-standalone-1.6.2/launcher.jar --disable-ansi-colors --disable-banner -cp . -c MainTest %s"
  },
  {
    id: 6,
    name: "MPI (OpenRTE 3.1.3) with C (GCC 8.3.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/mpicc %s main.c",
    run_cmd: "/usr/bin/mpiexec --allow-run-as-root --oversubscribe %s ./a.out"
  },
  {
    id: 7,
    name: "MPI (OpenRTE 3.1.3) with C++ (GCC 8.3.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/mpicxx %s main.cpp",
    run_cmd: "/usr/bin/mpiexec --allow-run-as-root --oversubscribe %s ./a.out"
  },
  {
    id: 8,
    name: "MPI (OpenRTE 3.1.3) with Python (3.7.3)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/bin/mpiexec --allow-run-as-root --oversubscribe %s /usr/bin/python3 script.py"
  },
  {
    id: 9,
    name: "Nim (stable)",
    is_archived: false,
    source_file: "main.nim",
    compile_cmd: "/usr/local/nim/bin/nim compile --nimcache:.cache/nim %s main.nim",
    run_cmd: "./main %s"
  },
  {
    id: 10,
    name: "Python for ML (3.7.3)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/bin/python3 script.py %s"
  },
  {
    id: 11,
    name: "Bosque (latest)",
    is_archived: false,
    source_file: "main.bsq",
    compile_cmd: "/usr/bin/node /usr/local/BosqueLanguage/impl/bin/runtimes/exegen/exegen.js -c g++-10 %s main.bsq",
    run_cmd:"./a.out %s"
  }
]