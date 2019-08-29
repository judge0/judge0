class AddMetadataToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :metadata, :json
  end
end
