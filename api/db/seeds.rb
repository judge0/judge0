languages = [
  {
    name: 'C (gcc 4.7)',
    compile_cmd: 'gcc-4.7'
  },
  {
    name: 'C (gcc 4.8)',
    compile_cmd: 'gcc-4.8'
  },
  {
    name: 'C (gcc 4.9)',
    compile_cmd: 'gcc-4.9'
  },
  {
    name: 'C (gcc 5.4)',
    compile_cmd: 'gcc-5'
  },
  {
    name: 'C++ (g++ 4.7)',
    compile_cmd: 'g++-4.7'
  },
  {
    name: 'C++ (g++ 4.8)',
    compile_cmd: 'g++-4.8'
  },
  {
    name: 'C++ (g++ 4.9)',
    compile_cmd: 'g++-4.9'
  },
  {
    name: 'C++ (g++ 5.4)',
    compile_cmd: 'g++-5'
  },
  {
    name: 'Java (SE 1.6)',
    compile_cmd: '/usr/lib/jvm/java-6-oracle/bin/javac',
    run_cmd: '/usr/lib/jvm/java-6-oracle/bin/java'
  },
  {
    name: 'Java (SE 1.7)',
    compile_cmd: '/usr/lib/jvm/java-7-oracle/bin/javac',
    run_cmd: '/usr/lib/jvm/java-7-oracle/bin/java'
  },
  {
    name: 'Java (SE 1.8)',
    compile_cmd: '/usr/lib/jvm/java-8-oracle/bin/javac',
    run_cmd: '/usr/lib/jvm/java-8-oracle/bin/java'
  },
  {
    name: 'Ruby (1.9.3)',
    run_cmd: '/opt/ruby/1.9.3/bin/ruby'
  },
  {
    name: 'Ruby (2.2.5)',
    run_cmd: '/opt/ruby/2.2.5/bin/ruby'
  },
  {
    name: 'Ruby (2.3.1)',
    run_cmd: '/opt/ruby/2.3.1/bin/ruby'
  },
  {
    name: 'Python (2.7.12)',
    run_cmd: 'python'
  },
  {
    name: 'Python (3.5.2)',
    run_cmd: 'python3'
  }
]


Language.delete_all
ActiveRecord::Base.connection.reset_pk_sequence!('languages')

languages.each do |language|
  Language.create(
    name: language[:name],
    compile_cmd: language[:compile_cmd],
    run_cmd: language[:run_cmd]
  )
end
