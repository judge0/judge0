languages = [
  {
    name: "Python (3.6.8)",
    source_file: "main.py",
    run_cmd: "/usr/local/python-3.6.8/bin/python3 main.py"
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