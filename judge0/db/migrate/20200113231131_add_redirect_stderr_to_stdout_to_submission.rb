class AddRedirectStderrToStdoutToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :redirect_stderr_to_stdout, :boolean
  end
end
