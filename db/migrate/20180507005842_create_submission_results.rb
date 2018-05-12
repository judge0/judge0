class CreateSubmissionResults < ActiveRecord::Migration[5.2]
  def change
    create_table :submission_results do |t|
      t.references :submission,       null: false
      t.references :test_case,        null: false
      t.references :stdout,           null: true
      t.references :stderr,           null: true
      t.references :compile_output,   null: true
      t.references :sandbox_message,  null: true
      t.references :internal_message, null: true
      t.decimal    :time
      t.decimal    :wall_time
      t.integer    :memory
      t.integer    :exit_code
      t.integer    :exit_signal
      t.integer    :status_id
      t.integer    :index
      t.datetime   :created_at
      t.datetime   :finished_at
    end

    add_index :submission_results, [:submission_id, :test_case_id]
  end
end
