class AddAdditionalFilesToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :additional_files, :binary
  end
end
