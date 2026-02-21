class AddHostsToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :queue_host, :string
    add_column :submissions, :execution_host, :string
  end
end
