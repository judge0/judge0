class CreateTestCases < ActiveRecord::Migration[5.2]
  def change
    create_table :test_cases do |t|
      t.string     :uuid,   null: false
      t.references :input,  null: true, index: false
      t.references :output, null: true, index: false
      t.timestamps
    end

    add_index :test_cases, :uuid, unique: true
    add_index :test_cases, [:input_id, :output_id], unique: true
  end
end
