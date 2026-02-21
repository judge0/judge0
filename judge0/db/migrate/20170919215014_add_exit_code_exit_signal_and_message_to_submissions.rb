class AddExitCodeExitSignalAndMessageToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :exit_code, :integer
    add_column :submissions, :exit_signal, :integer
    add_column :submissions, :message, :text
  end
end
