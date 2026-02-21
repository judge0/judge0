class AddUpdatedAtToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :updated_at, :datetime
  end
end
