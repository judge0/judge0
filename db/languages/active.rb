@languages ||= []
@languages +=
[
  {
    id: 43,
    name: "Plain Text",
    is_archived: false,
    source_file: "text.txt",
    run_cmd: "/bin/cat text.txt"
  },
  {
    id: 44,
    name: "Executable",
    is_archived: false,
    source_file: "a.out",
    run_cmd: "/bin/chmod +x a.out && ./a.out"
  },
  {
    id: 45,
    name: "Assembly (NASM 2.15.05)",
    is_archived: false,
    source_file: "main.asm",
    compile_cmd: "/usr/bin/nasm -f elf64 %s main.asm && /usr/bin/ld main.o -o a.out",
    run_cmd: "./a.out"
  },
  {
    id: 46,
    name: "Bash (5.1.16)",
    is_archived: false,
    source_file: "script.sh",
    run_cmd: "/bin/bash script.sh"
  },
  {
    id: 48,
    name: "C (GCC 11.4.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/gcc-11 %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 49,
    name: "C (GCC 12.3.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/gcc-12 %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 50,
    name: "C (GCC 13.1.0)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/gcc-13 %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 51,
    name: "C# (.NET 8.0)",
    is_archived: false,
    source_file: "Main.cs",
    compile_cmd: "mkdir -p /tmp/dotnet && cd /tmp/dotnet && echo '<Project Sdk=\"Microsoft.NET.Sdk\"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net8.0</TargetFramework></PropertyGroup></Project>' > project.csproj && cp /box/Main.cs . && /usr/bin/dotnet build -c Release -o /box/bin %s",
    run_cmd: "/usr/bin/dotnet /box/bin/project.dll"
  },
  {
    id: 52,
    name: "C++ (GCC 11.4.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/g++-11 %s main.cpp",
    run_cmd: "./a.out"
  },
  {
    id: 53,
    name: "C++ (GCC 12.3.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/g++-12 %s main.cpp",
    run_cmd: "./a.out"
  },
  {
    id: 54,
    name: "C++ (GCC 13.1.0)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/g++-13 %s main.cpp",
    run_cmd: "./a.out"
  },
  {
    id: 55,
    name: "Common Lisp (SBCL 2.2.9)",
    is_archived: false,
    source_file: "script.lisp",
    run_cmd: "/usr/bin/sbcl --script script.lisp"
  },
  {
    id: 56,
    name: "D (DMD 2.107.0)",
    is_archived: false,
    source_file: "main.d",
    compile_cmd: "/usr/bin/dmd %s main.d",
    run_cmd: "./main"
  },
  {
    id: 57,
    name: "Elixir (1.14.0)",
    is_archived: false,
    source_file: "script.exs",
    run_cmd: "/usr/bin/elixir script.exs"
  },
  {
    id: 58,
    name: "Erlang (OTP 25)",
    is_archived: false,
    source_file: "main.erl",
    run_cmd: "/bin/sed -i '1s/^/\\n/' main.erl && /usr/bin/escript main.erl"
  },
  {
    id: 59,
    name: "Fortran (GFortran 12.3.0)",
    is_archived: false,
    source_file: "main.f90",
    compile_cmd: "/usr/bin/gfortran %s main.f90",
    run_cmd: "./a.out"
  },
  {
    id: 60,
    name: "Go (1.22.0)",
    is_archived: false,
    source_file: "main.go",
    compile_cmd: "GOCACHE=/tmp/.cache/go-build /usr/local/go/bin/go build %s main.go",
    run_cmd: "./main"
  },
  {
    id: 61,
    name: "Haskell (GHC 9.0.2)",
    is_archived: false,
    source_file: "main.hs",
    compile_cmd: "/usr/bin/ghc %s main.hs",
    run_cmd: "./main"
  },
  {
    id: 62,
    name: "Java (OpenJDK 21)",
    is_archived: false,
    source_file: "Main.java",
    compile_cmd: "/usr/bin/javac %s Main.java",
    run_cmd: "/usr/bin/java Main"
  },
  {
    id: 63,
    name: "JavaScript (Node.js 20.11.0)",
    is_archived: false,
    source_file: "script.js",
    run_cmd: "/usr/local/bin/node script.js"
  },
  {
    id: 64,
    name: "Lua (5.4.4)",
    is_archived: false,
    source_file: "script.lua",
    run_cmd: "/usr/bin/lua script.lua"
  },
  {
    id: 65,
    name: "OCaml (4.13.1)",
    is_archived: false,
    source_file: "main.ml",
    compile_cmd: "/usr/bin/ocamlc %s main.ml -o main",
    run_cmd: "./main"
  },
  {
    id: 67,
    name: "Pascal (FPC 3.2.2)",
    is_archived: false,
    source_file: "main.pas",
    compile_cmd: "/usr/bin/fpc %s main.pas",
    run_cmd: "./main"
  },
  {
    id: 68,
    name: "PHP (8.1)",
    is_archived: false,
    source_file: "script.php",
    run_cmd: "/usr/bin/php script.php"
  },
  {
    id: 69,
    name: "Prolog (GNU Prolog 1.5.0)",
    is_archived: false,
    source_file: "main.pro",
    compile_cmd: "/usr/bin/gplc --no-top-level %s main.pro",
    run_cmd: "./main"
  },
  {
    id: 70,
    name: "Python (3.11)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/bin/python3.11 script.py"
  },
  {
    id: 71,
    name: "Python (3.12)",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/bin/python3.12 script.py"
  },
  {
    id: 72,
    name: "Ruby (3.3.0)",
    is_archived: false,
    source_file: "script.rb",
    run_cmd: "/usr/local/bin/ruby script.rb"
  },
  {
    id: 73,
    name: "Rust (1.75.0)",
    is_archived: false,
    source_file: "main.rs",
    compile_cmd: "/usr/local/bin/rustc %s main.rs",
    run_cmd: "./main"
  },
  {
    id: 74,
    name: "TypeScript (5.3.3)",
    is_archived: false,
    source_file: "script.ts",
    compile_cmd: "/usr/local/bin/tsc %s script.ts",
    run_cmd: "/usr/local/bin/node script.js"
  },
  {
    id: 75,
    name: "C (Clang 17)",
    is_archived: false,
    source_file: "main.c",
    compile_cmd: "/usr/bin/clang-17 %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 76,
    name: "C++ (Clang 17)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/clang++-17 %s main.cpp",
    run_cmd: "./a.out"
  },
  {
    id: 77,
    name: "COBOL (GnuCOBOL 3.1.2)",
    is_archived: false,
    source_file: "main.cob",
    compile_cmd: "/usr/bin/cobc -free -x %s main.cob",
    run_cmd: "./main"
  },
  {
    id: 78,
    name: "Kotlin (1.9.22)",
    is_archived: false,
    source_file: "Main.kt",
    compile_cmd: "/opt/kotlinc/bin/kotlinc %s Main.kt -include-runtime -d Main.jar",
    run_cmd: "/usr/bin/java -jar Main.jar"
  },
  {
    id: 80,
    name: "R (4.1.2)",
    is_archived: false,
    source_file: "script.r",
    run_cmd: "/usr/bin/Rscript script.r"
  },
  {
    id: 81,
    name: "Scala (3.3.1)",
    is_archived: false,
    source_file: "Main.scala",
    compile_cmd: "/opt/scala/bin/scalac %s Main.scala",
    run_cmd: "/opt/scala/bin/scala Main"
  },
  {
    id: 82,
    name: "SQL (SQLite 3.37.2)",
    is_archived: false,
    source_file: "script.sql",
    run_cmd: "/bin/cat script.sql | /usr/bin/sqlite3 db.sqlite"
  },
  {
    id: 83,
    name: "Swift (5.9.2)",
    is_archived: false,
    source_file: "Main.swift",
    compile_cmd: "/opt/swift/usr/bin/swiftc %s Main.swift",
    run_cmd: "./Main"
  },
  {
    id: 85,
    name: "Perl (5.34.0)",
    is_archived: false,
    source_file: "script.pl",
    run_cmd: "/usr/bin/perl script.pl"
  },
  {
    id: 86,
    name: "Clojure (1.11)",
    is_archived: false,
    source_file: "main.clj",
    run_cmd: "/usr/bin/clojure -M main.clj"
  },
  {
    id: 87,
    name: "F# (.NET 8.0)",
    is_archived: false,
    source_file: "script.fsx",
    run_cmd: "/usr/bin/dotnet fsi script.fsx"
  },
  {
    id: 88,
    name: "Groovy (4.0.18)",
    is_archived: false,
    source_file: "script.groovy",
    run_cmd: "/opt/groovy/bin/groovy script.groovy"
  },
  {
    id: 89,
    name: "Multi-file program",
    is_archived: false,
  },
  {
    id: 90,
    name: "Zig (0.11.0)",
    is_archived: false,
    source_file: "main.zig",
    compile_cmd: "/opt/zig/zig build-exe %s main.zig",
    run_cmd: "./main"
  },
  {
    id: 91,
    name: "Nim (2.0.2)",
    is_archived: false,
    source_file: "main.nim",
    compile_cmd: "/opt/nim/bin/nim compile %s main.nim",
    run_cmd: "./main"
  },
  {
    id: 92,
    name: "Dart (3.2)",
    is_archived: false,
    source_file: "main.dart",
    compile_cmd: "/usr/lib/dart/bin/dart compile exe %s main.dart -o main",
    run_cmd: "./main"
  },
  {
    id: 93,
    name: "Julia (1.10.0)",
    is_archived: false,
    source_file: "script.jl",
    run_cmd: "/opt/julia/bin/julia script.jl"
  },
  {
    id: 94,
    name: "Prolog (SWI-Prolog 9.0)",
    is_archived: false,
    source_file: "main.pl",
    run_cmd: "/usr/bin/swipl -q -t halt -s main.pl"
  }
]
