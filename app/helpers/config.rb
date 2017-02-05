module Config
  # https://raw.githubusercontent.com/ioi/isolate/master/isolate.1.txt

  # Default runtime limit for every program (in seconds). Decimal numbers are allowed.
  # Time in which the OS assigns the processor to different tasks is not counted.
  # Default: 1
  CPU_TIME_LIMIT = (ENV['CPU_TIME_LIMIT'].presence || 1).to_f

  # Maximum custom CPU_TIME_LIMIT.
  # Default: 15
  MAX_CPU_TIME_LIMIT = (ENV['MAX_CPU_TIME_LIMIT'].presence || 15).to_f

  # When a time limit is exceeded, wait for extra time (in seconds), before
  # killing the program. This has the advantage that the real execution time
  # is reported, even though it slightly exceeds the limit.
  # Default: 0.5
  CPU_EXTRA_TIME = (ENV['CPU_EXTRA_TIME'].presence || 0.5).to_f

  # Maximum custom CPU_EXTRA_TIME.
  # Default: 5
  MAX_CPU_EXTRA_TIME = (ENV['MAX_CPU_EXTRA_TIME'].presence || 5).to_f

  # Limit wall-clock time in seconds. Decimal numbers are allowed.
  # This clock measures the time from the start of the program to its exit,
  # so it does not stop when the program has lost the CPU or when it is waiting
  # for an external event. We recommend to use CPU_TIME_LIMIT as the main limit,
  # but set WALL_TIME_LIMIT to a much higher value as a precaution against
  # sleeping programs.
  # Default: 10
  WALL_TIME_LIMIT = (ENV['WALL_TIME_LIMIT'].presence || 10).to_f

  # Maximum custom WALL_TIME_LIMIT.
  # Default: 150
  MAX_WALL_TIME_LIMIT = (ENV['MAX_WALL_TIME_LIMIT'].presence || 150).to_f

  # Limit address space of the program in kilobytes.
  # Default: 128000
  MEMORY_LIMIT = (ENV['MEMORY_LIMIT'].presence || 128000 ).to_i# in KB

  # Maximum custom MEMORY_LIMIT.
  # Default: 512000
  MAX_MEMORY_LIMIT = (ENV['MAX_MEMORY_LIMIT'].presence || 512000).to_i

  # Limit process stack in kilobytes.
  # Default: 128000
  STACK_LIMIT = (ENV['STACK_LIMIT'].presence || 128000).to_i # in KB

  # Maximum custom STACK_LIMIT.
  # Default: 512000
  MAX_STACK_LIMIT = (ENV['MAX_STACK_LIMIT'].presence || 512000).to_i

  # Maximum number of processes and/or threads program can create.
  # Default: 15
  MAX_PROCESSES_AND_OR_THREADS = (ENV['MAX_PROCESSES_AND_OR_THREADS'].presence || 15).to_i

  # Maximum custom MAX_PROCESSES_AND_OR_THREADS.
  # Default: 30
  MAX_MAX_PROCESSES_AND_OR_THREADS = (ENV['MAX_MAX_PROCESSES_AND_OR_THREADS'].presence || 30).to_i

  # If true then CPU_TIME_LIMIT will be used as per process and thread.
  # Default false, i.e. CPU_TIME_LIMIT is set as a total limit for all processes and threads.
  ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT'] == "true"

  # If false, user won't be able to set ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT.
  # Default: true
  ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV['ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT'] != "false"

  # If true then MEMORY_LIMIT will be used as per process and thread.
  # Default: false, i.e. MEMORY_LIMIT is set as a total limit for all processes and threads.
  ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT'] == "true"

  # If false, user won't be able to set ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT.
  # Default: true
  ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV['ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT'] != "false"

  # Limit size of files created (or modified) by the program in kilobytes.
  # Default: 1024
  MAX_FILE_SIZE = (ENV['MAX_FILE_SIZE'].presence || 1024).to_i

  # Maximum custom MAX_FILE_SIZE.
  # Default: 4096
  MAX_MAX_FILE_SIZE = (ENV['MAX_MAX_FILE_SIZE'].presence || 4096).to_i

  # Run each program that many times and take average of time and memory.
  # Default: 1
  NUMBER_OF_RUNS = (ENV['NUMBER_OF_RUNS'].presence || 1).to_i

  # Maximum custom NUMBER_OF_RUNS.
  # Default: 20
  MAX_NUMBER_OF_RUNS = (ENV['MAX_NUMBER_OF_RUNS'].presence || 20).to_i

  def self.config_info
    @@default_confg ||= {
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
