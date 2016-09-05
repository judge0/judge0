class AddSourceFileToLanguage < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :source_file, :string
  end
end
