class RenameColumnTokenToUuidInSubmissions < ActiveRecord::Migration[5.2]
  def up
    rename_column :submissions, :token, :uuid
  end

  def down
    rename_column :submissions, :uuid, :token
  end
end
