class CreateTestCases < ActiveRecord::Migration[5.2]
  def change
    create_table :test_cases do |t|
      t.string     :uuid,   null: false
      t.references :input,  null: true
      t.references :output, null: true
      t.timestamps
    end

    add_index :test_cases, :uuid, unique: true
  end
end
