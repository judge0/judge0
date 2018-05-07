class CreateSubmissionResults < ActiveRecord::Migration[5.2]
  def change
    create_table :submission_results do |t|
      t.references :submission,       references: :submission
      t.references :test_case,        references: :test_case
      t.references :stdout,           references: :document
      t.references :stderr,           references: :document
      t.references :compile_output,   references: :document
      t.references :sandbox_message,  references: :document
      t.references :internal_message, references: :document
      t.decimal    :time
      t.decimal    :wall_time
      t.integer    :memory
      t.integer    :exit_code
      t.integer    :exit_signal
      t.integer    :status_id
      t.integer    :index
      t.datetime   :finished_at
      t.timestamps
    end

    add_index :submission_results, [:submission_id, :test_case_id]
  end
end
