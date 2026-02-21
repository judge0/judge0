class AddStderrToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :stderr, :text
  end
end
