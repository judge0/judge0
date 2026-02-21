class AddTimeToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :time, :decimal
  end
end
