class SubmissionSerializer < ActiveModel::Serializer
  attributes :token, :status, :stdout, :stderr,
             :created_at, :finished_at, :time, :memory,
             :number_of_runs, :cpu_time_limit, :cpu_extra_time,
             :wall_time_limit, :memory_limit, :stack_limit,
             :max_processes_and_or_threads,
             :enable_per_process_and_thread_time_limit, :enable_per_process_and_thread_memory_limit,
             :max_file_size

  def stdout
    instance_options[:base64] ? object[:stdout] : object.stdout
  end

  def stderr
    instance_options[:base64] ? object[:stderr] : object.stderr
  end
  
  def status
    { id: object.status_id, description: object.status.name }
  end
end
