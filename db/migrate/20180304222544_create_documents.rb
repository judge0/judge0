class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents, id: false do |t|
      t.string :digest, primary_key: true
      t.timestamps
    end

    add_index :documents, :digest, unique: true
  end
end