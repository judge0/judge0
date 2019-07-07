languages = [
  {
    name: "V (0.1.3)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.3/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.4)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.4/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.5)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.5/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.6)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.6/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.7)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.7/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.8)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.8/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.9)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.9/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.10)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.10/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.11)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.11/v main.v",
    run_cmd: "./main"
  },
  {
    name: "V (0.1.12)",
    source_file: "main.v",
    compile_cmd: "/usr/local/v-v0.1.12/v main.v",
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
