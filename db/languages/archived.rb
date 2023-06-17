@languages ||= []
@languages +=
[
  {
    id: 1,
    name: "Bash (4.4)",
    is_archived: true,
    source_file: "script.sh",
    run_cmd: "/usr/local/bash-4.4/bin/bash script.sh"
  },
  {
    id: 2,
    name: "Bash (4.0)",
    is_archived: true,
    source_file: "script.sh",
    run_cmd: "/usr/local/bash-4.0/bin/bash script.sh"
  },
  {
    id: 3,
    name: "Basic (fbc 1.05.0)",
    is_archived: true,
    source_file: "main.bas",
    compile_cmd: "/usr/local/fbc-1.05.0/bin/fbc %s main.bas",
    run_cmd: "./main"
  },
  {
    id: 4,
    name: "C (gcc 7.2.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-7.2.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 5,
    name: "C (gcc 6.4.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-6.4.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 6,
    name: "C (gcc 6.3.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-6.3.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 7,
    name: "C (gcc 5.4.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-5.4.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 8,
    name: "C (gcc 4.9.4)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-4.9.4/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 9,
    name: "C (gcc 4.8.5)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-4.8.5/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },

  {
    id: 10,
    name: "C++ (g++ 7.2.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-7.2.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-7.2.0/lib64 ./a.out"
  },
  {
    id: 11,
    name: "C++ (g++ 6.4.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-6.4.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-6.4.0/lib64 ./a.out"
  },
  {
    id: 12,
    name: "C++ (g++ 6.3.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-6.3.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-6.3.0/lib64 ./a.out"
  },
  {
    id: 13,
    name: "C++ (g++ 5.4.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-5.4.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-5.4.0/lib64 ./a.out"
  },
  {
    id: 14,
    name: "C++ (g++ 4.9.4)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-4.9.4/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-4.9.4/lib64 ./a.out"
  },
  {
    id: 15,
    name: "C++ (g++ 4.8.5)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-4.8.5/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-4.8.5/lib64 ./a.out"
  },
  {
    id: 16,
    name: "C# (mono 5.4.0.167)",
    is_archived: true,
    source_file: "Main.cs",
    compile_cmd: "/usr/local/mono-5.4.0.167/bin/mcs %s Main.cs",
    run_cmd: "/usr/local/mono-5.4.0.167/bin/mono Main.exe"
  },
  {
    id: 17,
    name: "C# (mono 5.2.0.224)",
    is_archived: true,
    source_file: "Main.cs",
    compile_cmd: "/usr/local/mono-5.2.0.224/bin/mcs %s Main.cs",
    run_cmd: "/usr/local/mono-5.2.0.224/bin/mono Main.exe"
  },
  {
    id: 18,
    name: "Clojure (1.8.0)",
    is_archived: true,
    source_file: "main.clj",
    run_cmd: "/usr/bin/java -cp /usr/local/clojure-1.8.0/clojure-1.8.0.jar clojure.main main.clj"
  },
  {
    id: 19,
    name: "Crystal (0.23.1)",
    is_archived: true,
    source_file: "main.cr",
    compile_cmd: "/usr/local/crystal-0.23.1-3/bin/crystal build %s main.cr",
    run_cmd: "./main"
  },
  {
    id: 20,
    name: "Elixir (1.5.1)",
    is_archived: true,
    source_file: "main.exs",
    run_cmd: "/usr/local/elixir-1.5.1/bin/elixir main.exs"
  },
  {
    id: 21,
    name: "Erlang (OTP 20.0)",
    is_archived: true,
    source_file: "main.erl",
    run_cmd: "/bin/sed -i \"s/^/\\n/\" main.erl && /usr/local/erlang-20.0/bin/escript main.erl"
  },
  {
    id: 22,
    name: "Go (1.9)",
    is_archived: true,
    source_file: "main.go",
    compile_cmd: "/usr/local/go-1.9/bin/go build %s main.go",
    run_cmd: "./main"
  },
  {
    id: 23,
    name: "Haskell (ghc 8.2.1)",
    is_archived: true,
    source_file: "main.hs",
    compile_cmd: "/usr/local/ghc-8.2.1/bin/ghc %s main.hs",
    run_cmd: "./main"
  },
  {
    id: 24,
    name: "Haskell (ghc 8.0.2)",
    is_archived: true,
    source_file: "main.hs",
    compile_cmd: "/usr/local/ghc-8.0.2/bin/ghc %s main.hs",
    run_cmd: "./main"
  },
  {
    id: 25,
    name: "Insect (5.0.0)",
    is_archived: true,
    source_file: "main.ins",
    run_cmd: "/usr/local/insect-5.0.0/insect main.ins"
  },
  {
    id: 26,
    name: "Java (OpenJDK 9 with Eclipse OpenJ9)",
    is_archived: true,
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk9-openj9/bin/javac %s Main.java",
    run_cmd: "/usr/local/openjdk9-openj9/bin/java Main"
  },
  {
    id: 27,
    name: "Java (OpenJDK 8)",
    is_archived: true,
    source_file: "Main.java",
    compile_cmd: "/usr/lib/jvm/java-8-openjdk-amd64/bin/javac %s Main.java",
    run_cmd: "/usr/lib/jvm/java-8-openjdk-amd64/bin/java Main",
  },
  {
    id: 28,
    name: "Java (OpenJDK 7)",
    is_archived: true,
    source_file: "Main.java",
    compile_cmd: "/usr/lib/jvm/java-7-openjdk-amd64/bin/javac %s Main.java",
    run_cmd: "/usr/lib/jvm/java-7-openjdk-amd64/bin/java Main",
  },
  {
    id: 29,
    name: "JavaScript (nodejs 8.5.0)",
    is_archived: true,
    source_file: "main.js",
    run_cmd: "/usr/local/node-8.5.0/bin/node main.js"
  },
  {
    id: 30,
    name: "JavaScript (nodejs 7.10.1)",
    is_archived: true,
    source_file: "main.js",
    run_cmd: "/usr/local/node-7.10.1/bin/node main.js"
  },
  {
    id: 31,
    name: "OCaml (4.05.0)",
    is_archived: true,
    source_file: "main.ml",
    compile_cmd: "/usr/local/ocaml-4.05.0/bin/ocamlc %s main.ml",
    run_cmd: "./a.out"
  },
  {
    id: 32,
    name: "Octave (4.2.0)",
    is_archived: true,
    source_file: "file.m",
    run_cmd: "/usr/local/octave-4.2.0/bin/octave-cli -q --no-gui --no-history file.m"
  },
  {
    id: 33,
    name: "Pascal (fpc 3.0.0)",
    is_archived: true,
    source_file: "main.pas",
    compile_cmd: "/usr/local/fpc-3.0.0/bin/fpc %s main.pas",
    run_cmd: "./main"
  },
  {
    id: 34,
    name: "Python (3.6.0)",
    is_archived: true,
    source_file: "main.py",
    run_cmd: "/usr/local/python-3.6.0/bin/python3 main.py"
  },
  {
    id: 35,
    name: "Python (3.5.3)",
    is_archived: true,
    source_file: "main.py",
    run_cmd: "/usr/local/python-3.5.3/bin/python3 main.py"
  },
  {
    id: 36,
    name: "Python (2.7.9)",
    is_archived: true,
    source_file: "main.py",
    run_cmd: "/usr/local/python-2.7.9/bin/python main.py"
  },
  {
    id: 37,
    name: "Python (2.6.9)",
    is_archived: true,
    source_file: "main.py",
    run_cmd: "/usr/local/python-2.6.9/bin/python main.py"
  },
  {
    id: 38,
    name: "Ruby (2.4.0)",
    is_archived: true,
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.4.0/bin/ruby main.rb"
  },
  {
    id: 39,
    name: "Ruby (2.3.3)",
    is_archived: true,
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.3.3/bin/ruby main.rb"
  },
  {
    id: 40,
    name: "Ruby (2.2.6)",
    is_archived: true,
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.2.6/bin/ruby main.rb"
  },
  {
    id: 41,
    name: "Ruby (2.1.9)",
    is_archived: true,
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.1.9/bin/ruby main.rb"
  },
  {
    id: 42,
    name: "Rust (1.20.0)",
    is_archived: true,
    source_file: "main.rs",
    compile_cmd: "/usr/local/rust-1.20.0/bin/rustc %s main.rs",
    run_cmd: "./main"
  },
  {
    id: 43,
    name: "Plain Text",
    is_archived: true,
    source_file: "text.txt",
    run_cmd: "/bin/cat text.txt"
  },
  {
    id: 44,
    name: "Executable",
    is_archived: true,
    source_file: "a.out",
    run_cmd: "/bin/chmod +x a.out && ./a.out"
  },
  {
    id: 45,
    name: "Assembly (NASM 2.14.02)",
    is_archived: true,
    source_file: "main.asm",
    compile_cmd: "/usr/local/nasm-2.14.02/bin/nasmld -f elf64 %s main.asm",
    run_cmd: "./a.out"
  },
  {
    id: 46,
    name: "Bash (5.0.0)",
    is_archived: true,
    source_file: "script.sh",
    run_cmd: "/usr/local/bash-5.0/bin/bash script.sh"
  },
  {
    id: 47,
    name: "Basic (FBC 1.07.1)",
    is_archived: true,
    source_file: "main.bas",
    compile_cmd: "/usr/local/fbc-1.07.1/bin/fbc %s main.bas",
    run_cmd: "./main"
  },
  {
    id: 48,
    name: "C (GCC 7.4.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-7.4.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 49,
    name: "C (GCC 8.3.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-8.3.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 50,
    name: "C (GCC 9.2.0)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 51,
    name: "C# (Mono 6.6.0.161)",
    is_archived: true,
    source_file: "Main.cs",
    compile_cmd: "/usr/local/mono-6.6.0.161/bin/mcs %s Main.cs",
    run_cmd: "/usr/local/mono-6.6.0.161/bin/mono Main.exe"
  },
  {
    id: 52,
    name: "C++ (GCC 7.4.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-7.4.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-7.4.0/lib64 ./a.out"
  },
  {
    id: 53,
    name: "C++ (GCC 8.3.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-8.3.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-8.3.0/lib64 ./a.out"
  },
  {
    id: 54,
    name: "C++ (GCC 9.2.0)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out"
  },
  {
    id: 55,
    name: "Common Lisp (SBCL 2.0.0)",
    is_archived: true,
    source_file: "script.lisp",
    run_cmd: "SBCL_HOME=/usr/local/sbcl-2.0.0/lib/sbcl /usr/local/sbcl-2.0.0/bin/sbcl --script script.lisp"
  },
  {
    id: 56,
    name: "D (DMD 2.089.1)",
    is_archived: true,
    source_file: "main.d",
    compile_cmd: "/usr/local/d-2.089.1/linux/bin64/dmd %s main.d",
    run_cmd: "./main"
  },
  {
    id: 57,
    name: "Elixir (1.9.4)",
    is_archived: true,
    source_file: "script.exs",
    run_cmd: "/usr/local/elixir-1.9.4/bin/elixir script.exs"
  },
  {
    id: 58,
    name: "Erlang (OTP 22.2)",
    is_archived: true,
    source_file: "main.erl",
    run_cmd: "/bin/sed -i '1s/^/\\n/' main.erl && /usr/local/erlang-22.2/bin/escript main.erl"
  },
  {
    id: 59,
    name: "Fortran (GFortran 9.2.0)",
    is_archived: true,
    source_file: "main.f90",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/gfortran %s main.f90",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out"
  },
  {
    id: 60,
    name: "Go (1.13.5)",
    is_archived: true,
    source_file: "main.go",
    compile_cmd: "GOCACHE=/tmp/.cache/go-build /usr/local/go-1.13.5/bin/go build %s main.go",
    run_cmd: "./main"
  },
  {
    id: 61,
    name: "Haskell (GHC 8.8.1)",
    is_archived: true,
    source_file: "main.hs",
    compile_cmd: "/usr/local/ghc-8.8.1/bin/ghc %s main.hs",
    run_cmd: "./main"
  },
  {
    id: 62,
    name: "Java (OpenJDK 13.0.1)",
    is_archived: true,
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk13/bin/javac %s Main.java",
    run_cmd: "/usr/local/openjdk13/bin/java Main"
  },
  {
    id: 63,
    name: "JavaScript (Node.js 12.14.0)",
    is_archived: true,
    source_file: "script.js",
    run_cmd: "/usr/local/node-12.14.0/bin/node script.js"
  },
  {
    id: 64,
    name: "Lua (5.3.5)",
    is_archived: true,
    source_file: "script.lua",
    compile_cmd: "/usr/local/lua-5.3.5/luac53 %s script.lua",
    run_cmd: "/usr/local/lua-5.3.5/lua53 ./luac.out"
  },
  {
    id: 65,
    name: "OCaml (4.09.0)",
    is_archived: true,
    source_file: "main.ml",
    compile_cmd: "/usr/local/ocaml-4.09.0/bin/ocamlc %s main.ml",
    run_cmd: "./a.out"
  },
  {
    id: 66,
    name: "Octave (5.1.0)",
    is_archived: true,
    source_file: "script.m",
    run_cmd: "/usr/local/octave-5.1.0/bin/octave-cli -q --no-gui --no-history script.m"
  },
  {
    id: 67,
    name: "Pascal (FPC 3.0.4)",
    is_archived: true,
    source_file: "main.pas",
    compile_cmd: "/usr/local/fpc-3.0.4/bin/fpc %s main.pas",
    run_cmd: "./main"
  },
  {
    id: 68,
    name: "PHP (7.4.1)",
    is_archived: true,
    source_file: "script.php",
    run_cmd: "/usr/local/php-7.4.1/bin/php script.php"
  },
  {
    id: 69,
    name: "Prolog (GNU Prolog 1.4.5)",
    is_archived: true,
    source_file: "main.pro",
    compile_cmd: "PATH=\"/usr/local/gprolog-1.4.5/gprolog-1.4.5/bin:$PATH\" /usr/local/gprolog-1.4.5/gprolog-1.4.5/bin/gplc --no-top-level %s main.pro",
    run_cmd: "./main"
  },
  {
    id: 70,
    name: "Python (2.7.17)",
    is_archived: true,
    source_file: "script.py",
    run_cmd: "/usr/local/python-2.7.17/bin/python2 script.py"
  },
  {
    id: 71,
    name: "Python (3.8.1)",
    is_archived: true,
    source_file: "script.py",
    run_cmd: "/usr/local/python-3.8.1/bin/python3 script.py"
  },
  {
    id: 72,
    name: "Ruby (2.7.0)",
    is_archived: true,
    source_file: "script.rb",
    run_cmd: "/usr/local/ruby-2.7.0/bin/ruby script.rb"
  },
  {
    id: 73,
    name: "Rust (1.40.0)",
    is_archived: true,
    source_file: "main.rs",
    compile_cmd: "/usr/local/rust-1.40.0/bin/rustc %s main.rs",
    run_cmd: "./main"
  },
  {
    id: 74,
    name: "TypeScript (3.7.4)",
    is_archived: true,
    source_file: "script.ts",
    compile_cmd: "/usr/bin/tsc %s script.ts",
    run_cmd: "/usr/local/node-12.14.0/bin/node script.js"
  },
  {
    id: 75,
    name: "C (Clang 7.0.1)",
    is_archived: true,
    source_file: "main.c",
    compile_cmd: "/usr/bin/clang-7 %s main.c",
    run_cmd: "./a.out"
  },
  {
    id: 76,
    name: "C++ (Clang 7.0.1)",
    is_archived: true,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/clang++-7 %s main.cpp",
    run_cmd: "./a.out"
  },
  {
    id: 77,
    name: "COBOL (GnuCOBOL 2.2)",
    is_archived: true,
    source_file: "main.cob",
    compile_cmd: "/usr/local/gnucobol-2.2/bin/cobc -free -x %s main.cob",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gnucobol-2.2/lib ./main"
  },
  {
    id: 78,
    name: "Kotlin (1.3.70)",
    is_archived: true,
    source_file: "Main.kt",
    compile_cmd: "/usr/local/kotlin-1.3.70/bin/kotlinc %s Main.kt",
    run_cmd: "/usr/local/kotlin-1.3.70/bin/kotlin MainKt"
  },
  {
    id: 79,
    name: "Objective-C (Clang 7.0.1)",
    is_archived: true,
    source_file: "main.m",
    compile_cmd: "/usr/bin/clang-7 `gnustep-config --objc-flags | sed 's/-W[^ ]* //g'` `gnustep-config --base-libs | sed 's/-shared-libgcc//'` -I/usr/lib/gcc/x86_64-linux-gnu/8/include main.m %s",
    run_cmd: "./a.out"
  },
  {
    id: 80,
    name: "R (4.0.0)",
    is_archived: true,
    source_file: "script.r",
    run_cmd: "/usr/local/r-4.0.0/bin/Rscript script.r"
  },
  {
    id: 81,
    name: "Scala (2.13.2)",
    is_archived: true,
    source_file: "Main.scala",
    compile_cmd: "/usr/local/scala-2.13.2/bin/scalac %s Main.scala",
    run_cmd: "/usr/local/scala-2.13.2/bin/scala Main"
  },
  {
    id: 82,
    name: "SQL (SQLite 3.27.2)",
    is_archived: true,
    source_file: "script.sql",
    run_cmd: "/bin/cat script.sql | /usr/bin/sqlite3 db.sqlite"
  },
  {
    id: 83,
    name: "Swift (5.2.3)",
    is_archived: true,
    source_file: "Main.swift",
    compile_cmd: "/usr/local/swift-5.2.3/bin/swiftc %s Main.swift",
    run_cmd: "./Main"
  },
  {
    id: 84,
    name: "Visual Basic.Net (vbnc 0.0.0.5943)",
    is_archived: true,
    source_file: "Main.vb",
    compile_cmd: "/usr/bin/vbnc %s Main.vb",
    run_cmd: "/usr/bin/mono Main.exe"
  },
  {
    id: 85,
    name: "Perl (5.28.1)",
    is_archived: true,
    source_file: "script.pl",
    run_cmd: "/usr/bin/perl script.pl"
  },
  {
    id: 86,
    name: "Clojure (1.10.1)",
    is_archived: true,
    source_file: "main.clj",
    run_cmd: "/usr/local/bin/java -jar /usr/local/clojure-1.10.1/clojure.jar main.clj"
  },
  {
    id: 87,
    name: "F# (.NET Core SDK 3.1.202)",
    is_archived: true,
    source_file: "script.fsx",
    run_cmd: "mkdir -p ~/.dotnet && touch ~/.dotnet/3.1.202.dotnetFirstUseSentinel && /usr/local/dotnet-sdk/dotnet fsi script.fsx"
  },
  {
    id: 88,
    name: "Groovy (3.0.3)",
    is_archived: true,
    source_file: "script.groovy",
    compile_cmd: "/usr/local/groovy-3.0.3/bin/groovyc %s script.groovy",
    run_cmd: "/usr/local/bin/java -cp \".:/usr/local/groovy-3.0.3/lib/*\" script"
  },
  {
    id: 89,
    name: "Multi-file program",
    is_archived: true,
  }
]