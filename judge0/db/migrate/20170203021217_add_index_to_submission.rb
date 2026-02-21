class AddIndexToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_index :submissions, :token
  end
end
