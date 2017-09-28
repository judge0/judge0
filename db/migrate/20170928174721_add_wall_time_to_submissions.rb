class AddWallTimeToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :wall_time, :decimal
  end
end
