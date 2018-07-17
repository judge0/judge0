class RenameColumnTokenToUuidInSubmissions < ActiveRecord::Migration[5.2]
  def up
    rename_column :submissions, :token, :uuid
    remove_index :submissions, :uuid
    add_index :submissions, :uuid, unique: true
  end

  def down
    remove_index :submissions, :uuid
    rename_column :submissions, :uuid, :token
    add_index :submissions, :token
  end
end
