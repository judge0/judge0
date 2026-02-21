class AddStartedAtToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :started_at, :datetime
    add_column :submissions, :queued_at, :datetime
  end
end
