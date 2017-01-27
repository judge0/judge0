class AddMemoryToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :memory, :integer
  end
end
