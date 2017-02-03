module Config
  # https://raw.githubusercontent.com/ioi/isolate/master/isolate.1.txt

  # Limit run time of the program in seconds. Fractional numbers are allowed.
  #	Time in which the OS assigns the processor to different tasks is not counted.
  # Default: 1
  CPU_TIME_LIMIT = ENV['CPU_TIME_LIMIT'].presence || 1

  # When a time limit is exceeded, wait for extra time in seconds, before
  # killing the program. This has the advantage that the real execution time
  # is reported, even though it slightly exceeds the limit. Fractional
  # numbers are again allowed.
  # Default: 0.5
  CPU_EXTRA_TIME = ENV['CPU_EXTRA_TIME'].presence || 0.5

  # Limit wall-clock time in seconds. Fractional values are allowed.
  # This clock measures the time from the start of the program to its exit,
  # so it does not stop when the program has lost the CPU or when it is waiting
  # for an external event. We recommend to use CPU_TIME_LIMIT as the main limit,
  # but set WALL_TIME_LIMIT to a much higher value as a precaution against
  # sleeping programs.
  # Default: 3
  WALL_TIME_LIMIT = ENV['WALL_TIME_LIMIT'].presence || 3

  # Limit address space of the program in kilobytes.
  # Default: 256000
  MEMORY_LIMIT = ENV['MEM_LIMIT'].presence || 256000 # in KB

  # Limit process stack in kilobytes
  # Default: 256000
  STACK_LIMIT = ENV['STACK_LIMIT'].presence || 256000 # in KB

  # Maximum number of processes and/or threads the program can create.
  # Default: 15
  MAX_PROCESSES_AND_OR_THREADS = ENV['MAX_PROCESSES_AND_OR_THREADS'].presence || 15

  # If "true" then TIME_LIMIT will be used as per process and thread.
  # Default "false", i.e. TIME_LIMIT is set as a total limit for all processes and threads
  ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT'] == "true"

  # If "true" then MEMORY_LIMIT will be used as per process and thread.
  # Default: "false", i.e. MEMORY_LIMIT is set as a total limit for all processes and threads
  ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT'] == "true"

  # Limit size of files created (or modified) by the program in kilobytes.
  # Default: 1
  MAX_FILE_SIZE = ENV['MAX_FILE_SIZE'].presence || 1

  def self.default_config
    @@default_confg ||= {
      "cpu_time_limit" => CPU_TIME_LIMIT,
      "cpu_extra_time" => CPU_EXTRA_TIME,
      "wall_time_limit" => WALL_TIME_LIMIT,
      "memory_limit" => MEMORY_LIMIT,
      "stack_limit" => STACK_LIMIT,
      "max_processes_and_or_threads" => MAX_PROCESSES_AND_OR_THREADS,
      "enable_per_process_and_thread_time_limit" => ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT,
      "enable_per_process_and_thread_memory_limit" => ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT,
      "max_file_size" => MAX_FILE_SIZE
    }
  end
end
