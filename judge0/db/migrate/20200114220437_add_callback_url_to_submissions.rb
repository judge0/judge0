class AddCallbackUrlToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :callback_url, :string
  end
end
