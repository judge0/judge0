module Config
  # For more info read:
  # https://github.com/judge0/api/blob/master/judge0-api.conf.default

  ENABLE_WAIT_RESULT = ENV['ENABLE_WAIT_RESULT'] != "false"
  CPU_TIME_LIMIT = (ENV['CPU_TIME_LIMIT'].presence || 2).to_f
  MAX_CPU_TIME_LIMIT = (ENV['MAX_CPU_TIME_LIMIT'].presence || 15).to_f
  CPU_EXTRA_TIME = (ENV['CPU_EXTRA_TIME'].presence || 0.5).to_f
  MAX_CPU_EXTRA_TIME = (ENV['MAX_CPU_EXTRA_TIME'].presence || 2).to_f
  WALL_TIME_LIMIT = (ENV['WALL_TIME_LIMIT'].presence || 5).to_f
  MAX_WALL_TIME_LIMIT = (ENV['MAX_WALL_TIME_LIMIT'].presence || 20).to_f
  MEMORY_LIMIT = (ENV['MEMORY_LIMIT'].presence || 128000).to_i # in KB
  MAX_MEMORY_LIMIT = (ENV['MAX_MEMORY_LIMIT'].presence || 256000).to_i
  STACK_LIMIT = (ENV['STACK_LIMIT'].presence || 64000).to_i # in KB
  MAX_STACK_LIMIT = (ENV['MAX_STACK_LIMIT'].presence || 128000).to_i
  MAX_PROCESSES_AND_OR_THREADS = (ENV['MAX_PROCESSES_AND_OR_THREADS'].presence || 30).to_i
  MAX_MAX_PROCESSES_AND_OR_THREADS = (ENV['MAX_MAX_PROCESSES_AND_OR_THREADS'].presence || 60).to_i
  ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT'] == "true"
  ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV['ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT'] != "false"
  ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT'] != "false"
  ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV['ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT'] != "false"
  MAX_FILE_SIZE = (ENV['MAX_FILE_SIZE'].presence || 1024).to_i
  MAX_MAX_FILE_SIZE = (ENV['MAX_MAX_FILE_SIZE'].presence || 4096).to_i
  NUMBER_OF_RUNS = (ENV['NUMBER_OF_RUNS'].presence || 1).to_i
  MAX_NUMBER_OF_RUNS = (ENV['MAX_NUMBER_OF_RUNS'].presence || 20).to_i

  def self.config_info
    @@default_confg ||= {
      "enable_wait_result": ENABLE_WAIT_RESULT,
      "cpu_time_limit": CPU_TIME_LIMIT,
      "max_cpu_time_limit": MAX_CPU_TIME_LIMIT,
      "cpu_extra_time": CPU_EXTRA_TIME,
      "max_cpu_extra_time": MAX_CPU_EXTRA_TIME,
      "wall_time_limit": WALL_TIME_LIMIT,
      "max_wall_time_limit": MAX_WALL_TIME_LIMIT,
      "memory_limit": MEMORY_LIMIT,
      "max_memory_limit": MAX_MEMORY_LIMIT,
      "stack_limit": STACK_LIMIT,
      "max_stack_limit": MAX_STACK_LIMIT,
      "max_processes_and_or_threads": MAX_PROCESSES_AND_OR_THREADS,
      "max_max_processes_and_or_threads": MAX_MAX_PROCESSES_AND_OR_THREADS,
      "enable_per_process_and_thread_time_limit": ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT,
      "allow_enable_per_process_and_thread_time_limit": ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT,
      "enable_per_process_and_thread_memory_limit": ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT,
      "allow_enable_per_process_and_thread_memory_limit": ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT,
      "max_file_size": MAX_FILE_SIZE,
      "max_max_file_size": MAX_MAX_FILE_SIZE,
      "number_of_runs": NUMBER_OF_RUNS,
      "max_number_of_runs": MAX_NUMBER_OF_RUNS
    }
  end
end
