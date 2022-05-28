module Config
  # For more info read:
  # https://github.com/judge0/judge0/blob/master/judge0.conf

  MAINTENANCE_MODE = ENV["MAINTENANCE_MODE"] == "true"
  ENABLE_WAIT_RESULT = ENV["ENABLE_WAIT_RESULT"] != "false"
  ENABLE_COMPILER_OPTIONS = ENV["ENABLE_COMPILER_OPTIONS"] != "false"
  ALLOWED_LANGUAGES_FOR_COMPILER_OPTIONS = ENV["ALLOWED_LANGUAGES_FOR_COMPILER_OPTIONS"].to_s.strip.split
  ENABLE_COMMAND_LINE_ARGUMENTS = ENV["ENABLE_COMMAND_LINE_ARGUMENTS"] != "false"
  ENABLE_SUBMISSION_DELETE = ENV["ENABLE_SUBMISSION_DELETE"] == "true"
  ENABLE_CALLBACKS = ENV["ENABLE_CALLBACKS"] != "false"
  CALLBACKS_MAX_TRIES = (ENV["CALLBACKS_MAX_TRIES"].presence || 3).to_i
  CALLBACKS_TIMEOUT = (ENV["CALLBACKS_TIMEOUT"].presence || 5).to_f
  ENABLE_ADDITIONAL_FILES = ENV["ENABLE_ADDITIONAL_FILES"] != "false"
  MAX_QUEUE_SIZE = (ENV["MAX_QUEUE_SIZE"].presence || 100).to_i
  CPU_TIME_LIMIT = (ENV["CPU_TIME_LIMIT"].presence || 5).to_f
  MAX_CPU_TIME_LIMIT = (ENV["MAX_CPU_TIME_LIMIT"].presence || 15).to_f
  CPU_EXTRA_TIME = (ENV["CPU_EXTRA_TIME"].presence || 1).to_f
  MAX_CPU_EXTRA_TIME = (ENV["MAX_CPU_EXTRA_TIME"].presence || 5).to_f
  WALL_TIME_LIMIT = (ENV["WALL_TIME_LIMIT"].presence || 10).to_f
  MAX_WALL_TIME_LIMIT = (ENV["MAX_WALL_TIME_LIMIT"].presence || 20).to_f
  MEMORY_LIMIT = (ENV["MEMORY_LIMIT"].presence || 128000).to_i # in KB
  MAX_MEMORY_LIMIT = (ENV["MAX_MEMORY_LIMIT"].presence || 512000).to_i
  STACK_LIMIT = (ENV["STACK_LIMIT"].presence || 64000).to_i # in KB
  MAX_STACK_LIMIT = (ENV["MAX_STACK_LIMIT"].presence || 128000).to_i
  MAX_PROCESSES_AND_OR_THREADS = (ENV["MAX_PROCESSES_AND_OR_THREADS"].presence || 60).to_i
  MAX_MAX_PROCESSES_AND_OR_THREADS = (ENV["MAX_MAX_PROCESSES_AND_OR_THREADS"].presence || 120).to_i
  ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV["ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT"] == "true"
  ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV["ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT"] != "false"
  ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV["ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT"] == "true"
  ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV["ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT"] != "false"
  MAX_FILE_SIZE = (ENV["MAX_FILE_SIZE"].presence || 1024).to_i
  MAX_MAX_FILE_SIZE = (ENV["MAX_MAX_FILE_SIZE"].presence || 4096).to_i
  NUMBER_OF_RUNS = (ENV["NUMBER_OF_RUNS"].presence || 1).to_i
  MAX_NUMBER_OF_RUNS = (ENV["MAX_NUMBER_OF_RUNS"].presence || 20).to_i
  REDIRECT_STDERR_TO_STDOUT = ENV["REDIRECT_STDERR_TO_STDOUT"] == "true"
  MAX_EXTRACT_SIZE = (ENV["MAX_EXTRACT_SIZE"].presence || 10240).to_i
  ENABLE_BATCHED_SUBMISSIONS = ENV["ENABLE_BATCHED_SUBMISSIONS"] != "false"
  MAX_SUBMISSION_BATCH_SIZE = (ENV["MAX_SUBMISSION_BATCH_SIZE"].presence || 20).to_i
  SUBMISSION_CACHE_DURATION = (ENV["SUBMISSION_CACHE_DURATION"].presence || 1).to_f
  USE_DOCS_AS_HOMEPAGE = ENV["USE_DOCS_AS_HOMEPAGE"] == "true"
  ALLOW_ENABLE_NETWORK = ENV["ALLOW_ENABLE_NETWORK"] != "false"
  ENABLE_NETWORK = ENV["ENABLE_NETWORK"] == "true"
  DISABLE_IMPLICIT_BASE64_ENCODING = ENV["DISABLE_IMPLICIT_BASE64_ENCODING"] == "true"

  def self.config_info
    @@default_confg ||= {
      "maintenance_mode": MAINTENANCE_MODE,
      "enable_wait_result": ENABLE_WAIT_RESULT,
      "enable_compiler_options": ENABLE_COMPILER_OPTIONS,
      "allowed_languages_for_compile_options": ALLOWED_LANGUAGES_FOR_COMPILER_OPTIONS,
      "enable_command_line_arguments": ENABLE_COMMAND_LINE_ARGUMENTS,
      "enable_submission_delete": ENABLE_SUBMISSION_DELETE,
      "enable_callbacks": ENABLE_CALLBACKS,
      "callbacks_max_tries": CALLBACKS_MAX_TRIES,
      "callbacks_timeout": CALLBACKS_TIMEOUT,
      "enable_additional_files": ENABLE_ADDITIONAL_FILES,
      "max_queue_size": MAX_QUEUE_SIZE,
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
      "max_number_of_runs": MAX_NUMBER_OF_RUNS,
      "redirect_stderr_to_stdout": REDIRECT_STDERR_TO_STDOUT,
      "max_extract_size": MAX_EXTRACT_SIZE,
      "enable_batched_submissions": ENABLE_BATCHED_SUBMISSIONS,
      "max_submission_batch_size": MAX_SUBMISSION_BATCH_SIZE,
      "submission_cache_duration": SUBMISSION_CACHE_DURATION,
      "use_docs_as_homepage": USE_DOCS_AS_HOMEPAGE,
      "allow_enable_network": ALLOW_ENABLE_NETWORK,
      "enable_network": ENABLE_NETWORK,
      "disable_implicit_base64_encoding": DISABLE_IMPLICIT_BASE64_ENCODING
    }
  end
end
