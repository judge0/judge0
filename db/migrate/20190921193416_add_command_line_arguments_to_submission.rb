class AddCommandLineArgumentsToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :command_line_arguments, :string
  end
end
