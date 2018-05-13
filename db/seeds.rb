languages = [
  {
    name: "Bash (4.4)",
    source_file: "script.sh",
    run_cmd: "/usr/local/bash-4.4/bin/bash script.sh"
  },
  {
    name: "Bash (4.0)",
    source_file: "script.sh",
    run_cmd: "/usr/local/bash-4.0/bin/bash script.sh"
  },


  {
    name: "Basic (fbc 1.05.0)",
    source_file: "main.bas",
    compile_cmd: "/usr/local/fbc-1.05.0/bin/fbc main.bas",
    run_cmd: "./main"
  },


  {
    name: "C (gcc 7.2.0)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-7.2.0/bin/gcc main.c -lm",
    run_cmd: "./a.out"
  },
  {
    name: "C (gcc 6.4.0)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-6.4.0/bin/gcc main.c -lm",
    run_cmd: "./a.out"
  },
  {
    name: "C (gcc 6.3.0)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-6.3.0/bin/gcc main.c -lm",
    run_cmd: "./a.out"
  },
  {
    name: "C (gcc 5.4.0)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-5.4.0/bin/gcc main.c -lm",
    run_cmd: "./a.out"
  },
  {
    name: "C (gcc 4.9.4)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-4.9.4/bin/gcc main.c -lm",
    run_cmd: "./a.out"
  },
  {
    name: "C (gcc 4.8.5)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-4.8.5/bin/gcc main.c -lm",
    run_cmd: "./a.out"
  },


  {
    name: "C++ (g++ 7.2.0)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-7.2.0/bin/g++ -Wl,-rpath,/usr/local/gcc-7.2.0/lib64 main.cpp",
    run_cmd: "./a.out"
  },
  {
    name: "C++ (g++ 6.4.0)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-6.4.0/bin/g++ -Wl,-rpath,/usr/local/gcc-6.4.0/lib64 main.cpp",
    run_cmd: "./a.out"
  },
  {
    name: "C++ (g++ 6.3.0)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-6.3.0/bin/g++ -Wl,-rpath,/usr/local/gcc-6.3.0/lib64 main.cpp",
    run_cmd: "./a.out"
  },
  {
    name: "C++ (g++ 5.4.0)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-5.4.0/bin/g++ -Wl,-rpath,/usr/local/gcc-5.4.0/lib64 main.cpp",
    run_cmd: "./a.out"
  },
  {
    name: "C++ (g++ 4.9.4)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-4.9.4/bin/g++ -Wl,-rpath,/usr/local/gcc-4.9.4/lib64 main.cpp",
    run_cmd: "./a.out"
  },
  {
    name: "C++ (g++ 4.8.5)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-4.8.5/bin/g++ -Wl,-rpath,/usr/local/gcc-4.8.5/lib64 main.cpp",
    run_cmd: "./a.out"
  },


  {
    name: "C# (mono 5.4.0.167)",
    source_file: "Main.cs",
    compile_cmd: "/usr/local/mono-5.4.0.167/bin/mcs Main.cs",
    run_cmd: "/usr/local/mono-5.4.0.167/bin/mono Main.exe"
  },
  {
    name: "C# (mono 5.2.0.224)",
    source_file: "Main.cs",
    compile_cmd: "/usr/local/mono-5.2.0.224/bin/mcs Main.cs",
    run_cmd: "/usr/local/mono-5.2.0.224/bin/mono Main.exe"
  },


  {
    name: "Clojure (1.8.0)",
    source_file: "main.clj",
    run_cmd: "/usr/bin/java -cp /usr/local/clojure-1.8.0/clojure-1.8.0.jar clojure.main main.clj"
  },


  {
    name: "Crystal (0.23.1)",
    source_file: "main.cr",
    compile_cmd: "/usr/local/crystal-0.23.1-3/bin/crystal build main.cr",
    run_cmd: "./main"
  },


  {
    name: "Elixir (1.5.1)",
    source_file: "main.exs",
    run_cmd: "/usr/local/elixir-1.5.1/bin/elixir main.exs"
  },


  {
    name: "Erlang (OTP 20.0)",
    source_file: "main.erl",
    compile_cmd: "/bin/sed -i \"s/^/\\n/\" main.erl",
    run_cmd: "/usr/local/erlang-20.0/bin/escript main.erl"
  },


  {
    name: "Go (1.9)",
    source_file: "main.go",
    compile_cmd: "/usr/local/go-1.9/bin/go build main.go",
    run_cmd: "./main"
  },


  {
    name: "Haskell (ghc 8.2.1)",
    source_file: "main.hs",
    compile_cmd: "/usr/local/ghc-8.2.1/bin/ghc main.hs -o a.out",
    run_cmd: "./a.out"
  },
  {
    name: "Haskell (ghc 8.0.2)",
    source_file: "main.hs",
    compile_cmd: "/usr/local/ghc-8.0.2/bin/ghc main.hs -o a.out",
    run_cmd: "./a.out"
  },


  {
    name: "Insect (5.0.0)",
    source_file: "main.ins",
    run_cmd: "/usr/local/insect-5.0.0/insect main.ins"
  },


  {
    name: "Java (OpenJDK 9 with Eclipse OpenJ9)",
    source_file: "Main.java",
    compile_cmd: "/usr/local/openjdk9-openj9/bin/javac Main.java",
    run_cmd: "/usr/local/openjdk9-openj9/bin/java Main"
  },
  {
    name: "Java (OpenJDK 8)",
    source_file: "Main.java",
    compile_cmd: "/usr/lib/jvm/java-8-openjdk-amd64/bin/javac Main.java",
    run_cmd: "/usr/lib/jvm/java-8-openjdk-amd64/bin/java Main",
  },
  {
    name: "Java (OpenJDK 7)",
    source_file: "Main.java",
    compile_cmd: "/usr/lib/jvm/java-7-openjdk-amd64/bin/javac Main.java",
    run_cmd: "/usr/lib/jvm/java-7-openjdk-amd64/bin/java Main",
  },


  {
    name: "JavaScript (nodejs 8.5.0)",
    source_file: "main.js",
    run_cmd: "/usr/local/node-8.5.0/bin/node main.js"
  },
  {
    name: "JavaScript (nodejs 7.10.1)",
    source_file: "main.js",
    run_cmd: "/usr/local/node-7.10.1/bin/node main.js"
  },


  {
    name: "OCaml (4.05.0)",
    source_file: "main.ml",
    compile_cmd: "/usr/local/ocaml-4.05.0/bin/ocamlc main.ml",
    run_cmd: "./a.out"
  },


  {
    name: "Octave (4.2.0)",
    source_file: "file.m",
    run_cmd: "/usr/local/octave-4.2.0/bin/octave-cli -q --no-gui file.m"
  },


  {
    name: "Pascal (fpc 3.0.0)",
    source_file: "main.pas",
    compile_cmd: "/usr/local/fpc-3.0.0/bin/fpc -v0 main.pas",
    run_cmd: "./main"
  },


  {
    name: "Python (3.6.0)",
    source_file: "main.py",
    run_cmd: "/usr/local/python-3.6.0/bin/python3 main.py"
  },
  {
    name: "Python (3.5.3)",
    source_file: "main.py",
    run_cmd: "/usr/local/python-3.5.3/bin/python3 main.py"
  },
  {
    name: "Python (2.7.9)",
    source_file: "main.py",
    run_cmd: "/usr/local/python-2.7.9/bin/python main.py"
  },
  {
    name: "Python (2.6.9)",
    source_file: "main.py",
    run_cmd: "/usr/local/python-2.6.9/bin/python main.py"
  },


  {
    name: "Ruby (2.4.0)",
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.4.0/bin/ruby main.rb"
  },
  {
    name: "Ruby (2.3.3)",
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.3.3/bin/ruby main.rb"
  },
  {
    name: "Ruby (2.2.6)",
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.2.6/bin/ruby main.rb"
  },
  {
    name: "Ruby (2.1.9)",
    source_file: "main.rb",
    run_cmd: "/usr/local/ruby-2.1.9/bin/ruby main.rb"
  },


  {
    name: "Rust (1.20.0)",
    source_file: "main.rs",
    compile_cmd: "/usr/local/rust-1.20.0/bin/rustc main.rs",
    run_cmd: "./main"
  },


  {
    name: "Text (plain text)",
    source_file: "source.txt",
    run_cmd: "/bin/cat source.txt"
  }
]

ActiveRecord::Base.transaction do
  Language.delete_all
  languages.each_with_index do |language, index|
    Language.create(
      id: index + 1,
      name: language[:name],
      compile_cmd: language[:compile_cmd],
      run_cmd: language[:run_cmd],
      source_file: language[:source_file]
    )
  end
end
