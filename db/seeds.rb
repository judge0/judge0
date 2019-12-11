require_relative 'languages/archived'
require_relative 'languages/active'

ActiveRecord::Base.transaction do
  Language.delete_all
  @languages.each_with_index do |language, index|
    Language.create(
      id: language[:id],
      name: language[:name],
      compile_cmd: language[:compile_cmd],
      run_cmd: language[:run_cmd],
      source_file: language[:source_file]
    )
  end
end
