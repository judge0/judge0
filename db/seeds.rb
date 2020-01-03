languages = [
  {
    id: 1,
    name: "Nim (stable)",
    is_archived: false,
    source_file: "main.nim",
    compile_cmd: "/usr/local/nim/bin/nim compile --nimcache:.cache/nim %s main.nim",
    run_cmd: "./main"
  }
]


ActiveRecord::Base.transaction do
  Language.unscoped.delete_all
  languages.each_with_index do |language, index|
    Language.create(
      id: language[:id],
      name: language[:name],
      is_archived: language[:is_archived],
      source_file: language[:source_file],
      compile_cmd: language[:compile_cmd],
      run_cmd: language[:run_cmd],
    )
  end
end
