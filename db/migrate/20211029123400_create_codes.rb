class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.text :text

      t.timestamps
    end
  end
end
