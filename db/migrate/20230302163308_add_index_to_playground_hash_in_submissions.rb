class AddIndexToPlaygroundHashInSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_index :submissions, :playground_hash
  end
end
