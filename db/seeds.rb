languages = [
  {
    name: 'Bash (4.4)',
    source_file: 'script.sh',
    run_cmd: '/usr/local/bash-4.4/bin/bash script.sh'
  },
  {
    name: 'Bash (4.0)',
    source_file: 'script.sh',
    run_cmd: '/usr/local/bash-4.0/bin/bash script.sh'
  },
  {
    name: 'C (gcc 6.3.0)',
    source_file: 'main.c',
    compile_cmd: '/usr/local/gcc-6.3.0/bin/gcc main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C (gcc 5.4.0)',
    source_file: 'main.c',
    compile_cmd: '/usr/local/gcc-5.4.0/bin/gcc main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C (gcc 4.9.4)',
    source_file: 'main.c',
    compile_cmd: '/usr/local/gcc-4.9.4/bin/gcc main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C (gcc 4.8.5)',
    source_file: 'main.c',
    compile_cmd: '/usr/local/gcc-4.8.5/bin/gcc main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 6.3.0)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/local/gcc-6.3.0/bin/g++ main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 5.4.0)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/local/gcc-5.4.0/bin/g++ main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 4.9.4)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/local/gcc-4.9.4/bin/g++ main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 4.8.5)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/local/gcc-4.8.5/bin/g++ main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C# (mono 4.8.0.472)',
    source_file: 'Main.cs',
    compile_cmd: '/usr/local/mono-4.8.0.472/bin/mcs Main.cs',
    run_cmd: '/usr/local/mono-4.8.0.472/bin/mono Main.exe'
  },
  {
    name: 'Haskell (ghc 8.0.2)',
    source_file: 'main.hs',
    compile_cmd: '/usr/local/ghc-8.0.2/bin/ghc main.hs -o a.out',
    run_cmd: './a.out'
  },
  {
    name: 'Java (OpenJDK 8)',
    source_file: 'Main.java',
    compile_cmd: '/usr/lib/jvm/java-8-openjdk-amd64/bin/javac Main.java',
    run_cmd: '/usr/lib/jvm/java-8-openjdk-amd64/bin/java Main',
  },
  {
    name: 'Java (OpenJDK 7)',
    source_file: 'Main.java',
    compile_cmd: '/usr/lib/jvm/java-7-openjdk-amd64/bin/javac Main.java',
    run_cmd: '/usr/lib/jvm/java-7-openjdk-amd64/bin/java Main',
  },
  {
    name: 'Octave (4.2.0)',
    source_file: 'file.m',
    run_cmd: '/usr/local/octave-4.2.0/bin/octave-cli -q file.m'
  },
  {
    name: 'Pascal (fpc 3.0.0)',
    source_file: 'main.pas',
    compile_cmd: '/usr/local/fpc-3.0.0/bin/fpc -v0 main.pas',
    run_cmd: './main'
  },
  {
    name: 'Python (3.6.0)',
    source_file: 'main.py',
    run_cmd: '/usr/local/python-3.6.0/bin/python3 main.py'
  },
  {
    name: 'Python (3.5.3)',
    source_file: 'main.py',
    run_cmd: '/usr/local/python-3.5.3/bin/python3 main.py'
  },
  {
    name: 'Python (2.7.9)',
    source_file: 'main.py',
    run_cmd: '/usr/local/python-2.7.9/bin/python main.py'
  },
  {
    name: 'Python (2.6.9)',
    source_file: 'main.py',
    run_cmd: '/usr/local/python-2.6.9/bin/python main.py'
  },
  {
    name: 'Ruby (2.4.0)',
    source_file: 'main.rb',
    run_cmd: '/usr/local/ruby-2.4.0/bin/ruby main.rb'
  },
  {
    name: 'Ruby (2.3.3)',
    source_file: 'main.rb',
    run_cmd: '/usr/local/ruby-2.3.3/bin/ruby main.rb'
  },
  {
    name: 'Ruby (2.2.6)',
    source_file: 'main.rb',
    run_cmd: '/usr/local/ruby-2.2.6/bin/ruby main.rb'
  },
  {
    name: 'Ruby (2.1.9)',
    source_file: 'main.rb',
    run_cmd: '/usr/local/ruby-2.1.9/bin/ruby main.rb'
  },
  {
    name: 'Node (6.10.1)',
    source_file: 'main.js',
    run_cmd: '/usr/local/node-6.10.1/bin/node main.js'
  },
  {
    name: 'Node (4.8.1)',
    source_file: 'main.js',
    run_cmd: '/usr/local/node-4.8.1/bin/node main.js'
  }
]


Language.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('languages')

languages.each do |language|
  Language.create(
    name: language[:name],
    compile_cmd: language[:compile_cmd],
    run_cmd: language[:run_cmd],
    source_file: language[:source_file]
  )
end
