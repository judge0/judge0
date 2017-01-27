languages = [
  {
    name: 'C (gcc 4.7)',
    source_file: 'main.c',
    compile_cmd: '/usr/bin/gcc-4.7 main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C (gcc 4.8)',
    source_file: 'main.c',
    compile_cmd: '/usr/bin/gcc-4.8 main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C (gcc 4.9)',
    source_file: 'main.c',
    compile_cmd: '/usr/bin/gcc-4.9 main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C (gcc 5.4)',
    source_file: 'main.c',
    compile_cmd: '/usr/bin/gcc-5 main.c',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 4.7)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/bin/g++-4.7 main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 4.8)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/bin/g++-4.8 main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 4.9)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/bin/g++-4.9 main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'C++ (g++ 5.4)',
    source_file: 'main.cpp',
    compile_cmd: '/usr/bin/g++-5 main.cpp',
    run_cmd: './a.out'
  },
  {
    name: 'Java (SE 1.6)',
    source_file: 'Main.java',
    compile_cmd: '/usr/lib/jvm/java-6-oracle/bin/javac Main.java',
    run_cmd: '/usr/lib/jvm/java-6-oracle/bin/java Main',
  },
  {
    name: 'Java (SE 1.7)',
    source_file: 'Main.java',
    compile_cmd: '/usr/lib/jvm/java-7-oracle/bin/javac Main.java',
    run_cmd: '/usr/lib/jvm/java-7-oracle/bin/java Main',
  },
  {
    name: 'Java (SE 1.8)',
    source_file: 'Main.java',
    compile_cmd: '/usr/lib/jvm/java-8-oracle/bin/javac Main.java',
    run_cmd: '/usr/lib/jvm/java-8-oracle/bin/java Main',
  },
  {
    name: 'Ruby (1.9.3)',
    source_file: 'main.rb',
    run_cmd: '/usr/lib/ruby/1.9.3/bin/ruby main.rb'
  },
  {
    name: 'Ruby (2.2.5)',
    source_file: 'main.rb',
    run_cmd: '/usr/lib/ruby/2.2.5/bin/ruby main.rb'
  },
  {
    name: 'Ruby (2.3.1)',
    source_file: 'main.rb',
    run_cmd: '/usr/lib/ruby/2.3.1/bin/ruby main.rb'
  },
  {
    name: 'Python (2.7.12)',
    source_file: 'main.py',
    run_cmd: '/usr/bin/python2.7 main.py'
  },
  {
    name: 'Python (3.5.2)',
    source_file: 'main.py',
    run_cmd: '/usr/bin/python3 main.py'
  },
  {
    name: 'Pascal (fpc 3.0.0)',
    source_file: 'main.pas',
    compile_cmd: '/usr/bin/fpc-3.0.0 -v0 main.pas',
    run_cmd: './main'
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
