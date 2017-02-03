class AddNumberOfRunsToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :number_of_runs, :integer
  end
end
