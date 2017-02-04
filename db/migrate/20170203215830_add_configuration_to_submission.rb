class AddConfigurationToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :cpu_time_limit, :decimal
    add_column :submissions, :cpu_extra_time, :decimal
    add_column :submissions, :wall_time_limit, :decimal
    add_column :submissions, :memory_limit, :integer
    add_column :submissions, :stack_limit, :integer
    add_column :submissions, :max_processes_and_or_threads, :integer
    add_column :submissions, :enable_per_process_and_thread_time_limit, :boolean
    add_column :submissions, :enable_per_process_and_thread_memory_limit, :boolean
    add_column :submissions, :max_file_size, :integer
  end
end
