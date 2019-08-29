class AddMetadataToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :webhooks, :json
  end
end
