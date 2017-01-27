class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.text :source_code
      t.integer :language_id
      t.text :input
      t.text :expected_output
      t.text :actual_output
      t.integer :status_id
      t.datetime :created_at
      t.datetime :finished_at
    end
  end
end
