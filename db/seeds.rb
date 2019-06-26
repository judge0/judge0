languages = [
  {
    name: "V (0.1.3)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-b00a47be/compiler/v main.v",
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
