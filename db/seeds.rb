languages = [
  {
    name: "Nim (stable)",
    source_file: "main.nim",
    compile_cmd: "/usr/local/nim/bin/nim compile --nimcache:~ %s main.nim",
    run_cmd: "./main"
  },
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
