class AddEnableNetworkToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :enable_network, :boolean
  end
end
