languages = [
  {
    name: "V (latest)",
    source_file: "main.v",
    compile_cmd: "/usr/local/bin/v %s main.v",
    run_cmd: "./main"
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
