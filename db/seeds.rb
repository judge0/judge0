languages = [
  {
    name: "C (gcc 9.2.0)",
    source_file: "main.c",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/gcc %s main.c",
    run_cmd: "./a.out"
  },
  {
    name: "C++ (g++ 9.2.0)",
    source_file: "main.cpp",
    compile_cmd: "/usr/local/gcc-9.2.0/bin/g++ %s main.cpp",
    run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-9.2.0/lib64 ./a.out"
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
