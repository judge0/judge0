class AddCompileOutputToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :compile_output, :text
  end
end
