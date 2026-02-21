class RenameInputToStdinInSubmissions < ActiveRecord::Migration[5.0]
  def change
    rename_column :submissions, :input, :stdin
  end
end
