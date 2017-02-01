class RenameActualOutputInSubmissionsToStdout < ActiveRecord::Migration[5.0]
  def change
    rename_column :submissions, :actual_output, :stdout
  end
end
