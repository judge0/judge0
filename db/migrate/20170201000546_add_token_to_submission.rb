class AddTokenToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :token, :string
  end
end
