class AddCompilerOptionsToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :compiler_options, :string
  end
end
