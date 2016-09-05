languages = [
  {
    name: 'C (gcc 4.7)',
    compile_cmd: 'gcc-4.7',
    run_cmd: './a.out',
    source_file: 'main.c'
  },
  {
    name: 'C (gcc 4.8)',
    compile_cmd: 'gcc-4.8',
    run_cmd: './a.out',
    source_file: 'main.c'
  },
  {
    name: 'C (gcc 4.9)',
    compile_cmd: 'gcc-4.9',
    run_cmd: './a.out',
    source_file: 'main.c'
  },
  {
    name: 'C (gcc 5.4)',
    compile_cmd: 'gcc-5',
    run_cmd: './a.out',
    source_file: 'main.c'
  },
  {
    name: 'C++ (g++ 4.7)',
    compile_cmd: 'g++-4.7',
    run_cmd: './a.out',
    source_file: 'main.cpp'
  },
  {
    name: 'C++ (g++ 4.8)',
    compile_cmd: 'g++-4.8',
    run_cmd: './a.out',
    source_file: 'main.cpp'
  },
  {
    name: 'C++ (g++ 4.9)',
    compile_cmd: 'g++-4.9',
    run_cmd: './a.out',
    source_file: 'main.cpp'
  },
  {
    name: 'C++ (g++ 5.4)',
    compile_cmd: 'g++-5',
    run_cmd: './a.out',
    source_file: 'main.cpp'
  },
  {
    name: 'Java (SE 1.6)',
    compile_cmd: '/usr/lib/jvm/java-6-oracle/bin/javac',
    run_cmd: '/usr/lib/jvm/java-6-oracle/bin/java',
    source_file: 'Main.java'
  },
  {
    name: 'Java (SE 1.7)',
    compile_cmd: '/usr/lib/jvm/java-7-oracle/bin/javac',
    run_cmd: '/usr/lib/jvm/java-7-oracle/bin/java',
    source_file: 'Main.java'
  },
  {
    name: 'Java (SE 1.8)',
    compile_cmd: '/usr/lib/jvm/java-8-oracle/bin/javac',
    run_cmd: '/usr/lib/jvm/java-8-oracle/bin/java',
    source_file: 'Main.java'
  },
  {
    name: 'Ruby (1.9.3)',
    run_cmd: '/opt/ruby/1.9.3/bin/ruby',
    source_file: 'main.rb'
  },
  {
    name: 'Ruby (2.2.5)',
    run_cmd: '/opt/ruby/2.2.5/bin/ruby',
    source_file: 'main.rb'
  },
  {
    name: 'Ruby (2.3.1)',
    run_cmd: '/opt/ruby/2.3.1/bin/ruby',
    source_file: 'main.rb'
  },
  {
    name: 'Python (2.7.12)',
    run_cmd: 'python',
    source_file: 'main.py'
  },
  {
    name: 'Python (3.5.2)',
    run_cmd: 'python3',
    source_file: 'main.py'
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
