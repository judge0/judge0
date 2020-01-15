class AddArchiveToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :archive, :binary
  end
end
