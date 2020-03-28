class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients, id: :string do |t|
    end
  end
end
