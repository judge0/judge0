class RenameActualOutputinSubmissionsToOutput < ActiveRecord::Migration[5.0]
  def change
    rename_column :submissions, :actual_output, :output
  end
end
