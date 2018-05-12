class CreateTestSuites < ActiveRecord::Migration[5.2]
  def change
    create_table :test_suites do |t|
      t.string :uuid,          null: false
      t.text   :test_case_ids, null: false
      t.timestamps
    end

    add_index :test_suites, :uuid,          unique: true
    add_index :test_suites, :test_case_ids, unique: true
  end
end
