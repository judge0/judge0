class AddPlaygroundHashToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :playground_hash, :string
  end
end
