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
    name: "Assembly (NASM 2.14.02)",
    is_archived: false,
    source_file: "main.asm",
    compile_cmd: "/usr/local/nasm-2.14.02/bin/nasmld -f elf64 %s main.asm",
    run_cmd: "./a.out"
  },
  {
    id: 46,
    name: "Bash (5.0.0)",
    is_archived: false,
    source_file: "script.sh",
    run_cmd: "/usr/local/bash-5.0/bin/bash script.sh"
  },
  {
    id: 47,
    name: "Basic (FBC 1.07.1)",
    is_archived: false,
    source_file: "main.bas",
    compile_cmd: "/usr/local/fbc-1.07.1/bin/fbc %s main.bas",
    run_cmd: "./main"
  },
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
    id: 55,
    name: "Common Lisp (SBCL 2.0.0)",
    is_archived: false,
    source_file: "script.lisp",
    run_cmd: "SBCL_HOME=/usr/local/sbcl-2.0.0/lib/sbcl /usr/local/sbcl-2.0.0/bin/sbcl --script script.lisp"
  },
  {
    id: 56,
    name: "D (DMD 2.089.1)",
    is_archived: false,
    source_file: "main.d",
    compile_cmd: "/usr/local/d-2.089.1/linux/bin64/dmd %s main.d",
    run_cmd: "./main"
  },
  {
    id: 57,
    name: "Elixir (1.9.4)",
    is_archived: false,
    source_file: "script.exs",
    run_cmd: "/usr/local/elixir-1.9.4/bin/elixir script.exs"
  },
  {
    id: 58,
    name: "Erlang (OTP 22.2)",
    is_archived: false,
    source_file: "main.erl",
    run_cmd: "/bin/sed -i '1s/^/\\n/' main.erl && /usr/local/erlang-22.2/bin/escript main.erl"
  },
  {
    id: 59,
    name: "Fortran (GFortran 9.2.0)",
    is_archived: false,
    source_file: "main.f90",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/gfortran %s main.f90",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out"
  },
  {
    id: 60,
    name: "Go (1.13.5)",
    is_archived: false,
    source_file: "main.go",
    compile_cmd: "GOCACHE=/tmp/.cache/go-build /usr/local/go-1.13.5/bin/go build %s main.go",
    run_cmd: "./main"
  },
  {
    id: 61,
    name: "Haskell (GHC 8.8.1)",
    is_archived: false,
    source_file: "main.hs",
    compile_cmd: "/usr/local/ghc-8.8.1/bin/ghc %s main.hs",
    run_cmd: "./main"
  },
  {
    id: 62,
    name: "Java (OpenJDK 13.0.1)",
    is_archived: false,
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk13/bin/javac %s Main.java",
    run_cmd: "/usr/local/openjdk13/bin/java Main"
  },
  {
    id: 63,
    name: "JavaScript (Node.js 12.14.0)",
    is_archived: false,
    source_file: "script.js",
    run_cmd: "/usr/local/node-12.14.0/bin/node script.js"
  },
  {
    id: 64,
    name: "Lua (5.3.5)",
    is_archived: false,
    source_file: "script.lua",
    compile_cmd: "/usr/local/lua-5.3.5/luac53 %s script.lua",
    run_cmd: "/usr/local/lua-5.3.5/lua53 ./luac.out"
  },
  {
    id: 65,
    name: "OCaml (4.09.0)",
    is_archived: false,
    source_file: "main.ml",
    compile_cmd: "/usr/local/ocaml-4.09.0/bin/ocamlc %s main.ml",
    run_cmd: "./a.out"
  },
  {
    id: 66,
    name: "Octave (5.1.0)",
    is_archived: false,
    source_file: "script.m",
    run_cmd: "/usr/local/octave-5.1.0/bin/octave-cli -q --no-gui --no-history script.m"
  },
  {
    id: 67,
    name: "Pascal (FPC 3.0.4)",
    is_archived: false,
    source_file: "main.pas",
    compile_cmd: "/usr/local/fpc-3.0.4/bin/fpc %s main.pas",
    run_cmd: "./main"
  },
  {
    id: 68,
    name: "PHP (7.4.1)",
    is_archived: false,
    source_file: "script.php",
    run_cmd: "/usr/local/php-7.4.1/bin/php script.php"
  },
  {
    id: 69,
    name: "Prolog (GNU Prolog 1.4.5)",
    is_archived: false,
    source_file: "main.pro",
    compile_cmd: "PATH=\"/usr/local/gprolog-1.4.5/gprolog-1.4.5/bin:$PATH\" /usr/local/gprolog-1.4.5/gprolog-1.4.5/bin/gplc --no-top-level %s main.pro",
    run_cmd: "./main"
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
    id: 73,
    name: "Rust (1.40.0)",
    is_archived: false,
    source_file: "main.rs",
    compile_cmd: "/usr/local/rust-1.40.0/bin/rustc %s main.rs",
    run_cmd: "./main"
  },
  {
    id: 74,
    name: "TypeScript (3.7.4)",
    is_archived: false,
    source_file: "script.ts",
    compile_cmd: "/usr/bin/tsc %s script.ts",
    run_cmd: "/usr/local/node-12.14.0/bin/node script.js"
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
    id: 77,
    name: "COBOL (GnuCOBOL 2.2)",
    is_archived: false,
    source_file: "main.cob",
    compile_cmd: "/usr/local/gnucobol-2.2/bin/cobc -free -x %s main.cob",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gnucobol-2.2/lib ./main"
  },
  {
    id: 78,
    name: "Kotlin (1.3.70)",
    is_archived: false,
    source_file: "Main.kt",
    compile_cmd: "/usr/local/kotlin-1.3.70/bin/kotlinc %s Main.kt",
    run_cmd: "/usr/local/kotlin-1.3.70/bin/kotlin MainKt"
  },
  {
    id: 79,
    name: "Objective-C (Clang 7.0.1)",
    is_archived: false,
    source_file: "main.m",
    compile_cmd: "/usr/bin/clang-7 `gnustep-config --objc-flags | sed 's/-W[^ ]* //g'` `gnustep-config --base-libs | sed 's/-shared-libgcc//'` -I/usr/lib/gcc/x86_64-linux-gnu/8/include main.m %s",
    run_cmd: "./a.out"
  },
  {
    id: 80,
    name: "R (4.0.0)",
    is_archived: false,
    source_file: "script.r",
    run_cmd: "/usr/local/r-4.0.0/bin/Rscript script.r"
  },
  {
    id: 81,
    name: "Scala (2.13.2)",
    is_archived: false,
    source_file: "Main.scala",
    compile_cmd: "/usr/local/scala-2.13.2/bin/scalac %s Main.scala",
    run_cmd: "/usr/local/scala-2.13.2/bin/scala Main"
  },
  {
    id: 82,
    name: "SQL (SQLite 3.27.2)",
    is_archived: false,
    source_file: "script.sql",
    run_cmd: "/bin/cat script.sql | /usr/bin/sqlite3 db.sqlite"
  },
  {
    id: 83,
    name: "Swift (5.2.3)",
    is_archived: false,
    source_file: "Main.swift",
    compile_cmd: "/usr/local/swift-5.2.3/bin/swiftc %s Main.swift",
    run_cmd: "./Main"
  },
  {
    id: 84,
    name: "Visual Basic.Net (vbnc 0.0.0.5943)",
    is_archived: false,
    source_file: "Main.vb",
    compile_cmd: "/usr/bin/vbnc %s Main.vb",
    run_cmd: "/usr/bin/mono Main.exe"
  },
  {
    id: 85,
    name: "Perl (5.28.1)",
    is_archived: false,
    source_file: "script.pl",
    run_cmd: "/usr/bin/perl script.pl"
  },
  {
    id: 86,
    name: "Clojure (1.10.1)",
    is_archived: false,
    source_file: "main.clj",
    run_cmd: "/usr/local/bin/java -jar /usr/local/clojure-1.10.1/clojure.jar main.clj"
  },
  {
    id: 87,
    name: "F# (.NET Core SDK 3.1.202)",
    is_archived: false,
    source_file: "script.fsx",
    run_cmd: "mkdir -p ~/.dotnet && touch ~/.dotnet/3.1.202.dotnetFirstUseSentinel && /usr/local/dotnet-sdk/dotnet fsi script.fsx"
  },
  {
    id: 88,
    name: "Groovy (3.0.3)",
    is_archived: false,
    source_file: "script.groovy",
    compile_cmd: "/usr/local/groovy-3.0.3/bin/groovyc %s script.groovy",
    run_cmd: "/usr/local/bin/java -cp \".:/usr/local/groovy-3.0.3/lib/*\" script"
  },
  {
    id: 89,
    name: "Multi-file program",
    is_archived: false,
  }
]