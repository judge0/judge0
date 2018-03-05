class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :uuid, null: false
      t.string :digest, null: false

      t.timestamps
    end

    add_index :documents, :uuid, unique: true
    add_index :documents, :digest, unique: true
  end
end