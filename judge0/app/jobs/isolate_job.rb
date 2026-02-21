class IsolateJob < ApplicationJob
  retry_on RuntimeError, wait: 0.1.seconds, attempts: 100

  queue_as ENV["JUDGE0_VERSION"].to_sym

  STDIN_FILE_NAME = "stdin.txt"
  STDOUT_FILE_NAME = "stdout.txt"
  STDERR_FILE_NAME = "stderr.txt"
  METADATA_FILE_NAME = "metadata.txt"
  ADDITIONAL_FILES_ARCHIVE_FILE_NAME = "additional_files.zip"

  attr_reader :submission, :cgroups,
              :box_id, :workdir, :boxdir, :tmpdir,
              :source_file, :stdin_file, :stdout_file,
              :stderr_file, :metadata_file, :additional_files_archive_file

  def perform(submission_id)
    @submission = Submission.find(submission_id)
    submission.update(status: Status.process, started_at: DateTime.now, execution_host: ENV["HOSTNAME"])

    time = []
    memory = []

    submission.number_of_runs.times do
      initialize_workdir
      if compile == :failure
        cleanup
        return
      end
      run
      verify

      time << submission.time
      memory << submission.memory

      cleanup
      break if submission.status != Status.ac
    end

    submission.time = time.inject(&:+).to_f / time.size
    submission.memory = memory.inject(&:+).to_f / memory.size
    submission.save

  rescue Exception => e
    raise e.message unless submission
    submission.update(message: e.message, status: Status.boxerr, finished_at: DateTime.now)
    cleanup(raise_exception = false)
  ensure
    call_callback
  end

  private

  def initialize_workdir
    @box_id = submission.id%2147483647
    @cgroups = (!submission.enable_per_process_and_thread_time_limit || !submission.enable_per_process_and_thread_memory_limit) ? "--cg" : ""
    @workdir = `isolate #{cgroups} -b #{box_id} --init`.chomp
    @boxdir = workdir + "/box"
    @tmpdir = workdir + "/tmp"
    @source_file = boxdir + "/" + submission.language.source_file.to_s
    @stdin_file = workdir + "/" + STDIN_FILE_NAME
    @stdout_file = workdir + "/" + STDOUT_FILE_NAME
    @stderr_file = workdir + "/" + STDERR_FILE_NAME
    @metadata_file = workdir + "/" + METADATA_FILE_NAME
    @additional_files_archive_file = boxdir + "/" + ADDITIONAL_FILES_ARCHIVE_FILE_NAME

    [stdin_file, stdout_file, stderr_file, metadata_file].each do |f|
      initialize_file(f)
    end

    File.open(source_file, "wb") { |f| f.write(submission.source_code) } unless submission.is_project
    File.open(stdin_file, "wb") { |f| f.write(submission.stdin) }

    extract_archive
  end

  def initialize_file(file)
    `sudo touch #{file} && sudo chown $(whoami): #{file}`
  end

  def extract_archive
    return unless submission.additional_files?

    File.open(additional_files_archive_file, "wb") { |f| f.write(submission.additional_files) }

    command = "isolate #{cgroups} \
    -s \
    -b #{box_id} \
    --stderr-to-stdout \
    -t 2 \
    -x 1 \
    -w 4 \
    -k #{Config::MAX_STACK_LIMIT} \
    -p#{Config::MAX_MAX_PROCESSES_AND_OR_THREADS} \
    #{submission.enable_per_process_and_thread_time_limit ? (cgroups.present? ? "--no-cg-timing" : "") : "--cg-timing"} \
    #{submission.enable_per_process_and_thread_memory_limit ? "-m " : "--cg-mem="}#{Config::MAX_MEMORY_LIMIT} \
    -f #{Config::MAX_EXTRACT_SIZE} \
    --run \
    -- /usr/bin/unzip -n -qq #{ADDITIONAL_FILES_ARCHIVE_FILE_NAME} \
    "

    puts "[#{DateTime.now}] Extracting archive for submission #{submission.token} (#{submission.id}):"
    puts command.gsub(/\s+/, " ")
    puts

    `#{command}`

    File.delete(additional_files_archive_file)
  end

  def compile
    unless submission.is_project
      return :success unless submission.language.compile_cmd
    end

    compile_script = boxdir + "/" + "compile.sh"

    acceptable_project_compile_scripts = [compile_script, boxdir + "/" + "compile"]
    if submission.is_project
      compile_file_exists = false
      acceptable_project_compile_scripts.each do |f|
        if File.file?(f)
          compile_script = f
          compile_file_exists = true
          break
        end
      end

      unless compile_file_exists
        return :success # If compile script does not exist then this project does not need to be compiled.
      end
    else
      # gsub can be skipped if compile script is used, but is kept for additional security.
      compiler_options = submission.compiler_options.to_s.strip.encode("UTF-8", invalid: :replace).gsub(/[$&;<>|`]/, "")
      File.open(compile_script, "w") { |f| f.write("#{submission.language.compile_cmd % compiler_options}") }
    end

    compile_output_file = workdir + "/" + "compile_output.txt"
    initialize_file(compile_output_file)

    command = "isolate #{cgroups} \
    -s \
    -b #{box_id} \
    -M #{metadata_file} \
    --stderr-to-stdout \
    -i /dev/null \
    -t #{Config::MAX_CPU_TIME_LIMIT} \
    -x 0 \
    -w #{Config::MAX_WALL_TIME_LIMIT} \
    -k #{Config::MAX_STACK_LIMIT} \
    -p#{Config::MAX_MAX_PROCESSES_AND_OR_THREADS} \
    #{submission.enable_per_process_and_thread_time_limit ? (cgroups.present? ? "--no-cg-timing" : "") : "--cg-timing"} \
    #{submission.enable_per_process_and_thread_memory_limit ? "-m " : "--cg-mem="}#{Config::MAX_MEMORY_LIMIT} \
    -f #{Config::MAX_MAX_FILE_SIZE} \
    -E HOME=/tmp \
    -E PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\" \
    -E LANG -E LANGUAGE -E LC_ALL -E JUDGE0_HOMEPAGE -E JUDGE0_SOURCE_CODE -E JUDGE0_MAINTAINER -E JUDGE0_VERSION \
    -d /etc:noexec \
    --run \
    -- /bin/bash $(basename #{compile_script}) > #{compile_output_file} \
    "

    puts "[#{DateTime.now}] Compiling submission #{submission.token} (#{submission.id}):"
    puts command.gsub(/\s+/, " ")
    puts

    `#{command}`
    process_status = $?

    compile_output = File.read(compile_output_file)
    compile_output = nil if compile_output.empty?
    submission.compile_output = compile_output

    metadata = get_metadata

    reset_metadata_file

    files_to_remove = [compile_output_file]
    files_to_remove << compile_script unless submission.is_project
    files_to_remove.each do |f|
      `sudo rm -rf #{f}`
    end

    return :success if process_status.success?

    if metadata[:status] == "TO"
      submission.compile_output = "Compilation time limit exceeded."
    end

    submission.finished_at = DateTime.now
    submission.time = nil
    submission.wall_time = nil
    submission.memory = nil
    submission.stdout = nil
    submission.stderr = nil
    submission.exit_code = nil
    submission.exit_signal = nil
    submission.message = nil
    submission.status = Status.ce
    submission.save

    return :failure
  end

  def run
    run_script = boxdir + "/" + "run.sh"

    acceptable_project_run_scripts = [run_script, boxdir + "/" + "run"]
    acceptable_project_run_scripts.each do |f|
      if File.file?(f)
        run_script = f
        break
      end
    end

    unless submission.is_project
      # gsub is mandatory!
      command_line_arguments = submission.command_line_arguments.to_s.strip.encode("UTF-8", invalid: :replace).gsub(/[$&;<>|`]/, "")
      File.open(run_script, "w") { |f| f.write("#{submission.language.run_cmd} #{command_line_arguments}")}
    end

    command = "isolate #{cgroups} \
    -s \
    -b #{box_id} \
    -M #{metadata_file} \
    #{submission.redirect_stderr_to_stdout ? "--stderr-to-stdout" : ""} \
    #{submission.enable_network ? "--share-net" : ""} \
    -t #{submission.cpu_time_limit} \
    -x #{submission.cpu_extra_time} \
    -w #{submission.wall_time_limit} \
    -k #{submission.stack_limit} \
    -p#{submission.max_processes_and_or_threads} \
    #{submission.enable_per_process_and_thread_time_limit ? (cgroups.present? ? "--no-cg-timing" : "") : "--cg-timing"} \
    #{submission.enable_per_process_and_thread_memory_limit ? "-m " : "--cg-mem="}#{submission.memory_limit} \
    -f #{submission.max_file_size} \
    -E HOME=/tmp \
    -E PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\" \
    -E LANG -E LANGUAGE -E LC_ALL -E JUDGE0_HOMEPAGE -E JUDGE0_SOURCE_CODE -E JUDGE0_MAINTAINER -E JUDGE0_VERSION \
    -d /etc:noexec \
    --run \
    -- /bin/bash $(basename #{run_script}) \
    < #{stdin_file} > #{stdout_file} 2> #{stderr_file} \
    "

    puts "[#{DateTime.now}] Running submission #{submission.token} (#{submission.id}):"
    puts command.gsub(/\s+/, " ")
    puts

    `#{command}`

    `sudo rm #{run_script}` unless submission.is_project
  end

  def verify
    submission.finished_at = DateTime.now

    metadata = get_metadata

    program_stdout = File.read(stdout_file)
    program_stdout = nil if program_stdout.empty?

    program_stderr = File.read(stderr_file)
    program_stderr = nil if program_stderr.empty?

    submission.time = metadata[:time]
    submission.wall_time = metadata[:"time-wall"]
    submission.memory = (cgroups.present? ? metadata[:"cg-mem"] : metadata[:"max-rss"])
    submission.stdout = program_stdout
    submission.stderr = program_stderr
    submission.exit_code = metadata[:exitcode].try(:to_i) || 0
    submission.exit_signal = metadata[:exitsig].try(:to_i)
    submission.message = metadata[:message]
    submission.status = determine_status(metadata[:status], submission.exit_signal)

    # After adding support for compiler_options and command_line_arguments
    # status "Exec Format Error" will no longer occur because compile and run
    # is done inside a dynamically created bash script, thus isolate doesn't call
    # execve directily on submission.language.compile_cmd or submission.langauge.run_cmd.
    # Consequence of running compile and run through bash script is that when
    # target binary is not found then submission gets status "Runtime Error (NZEC)".
    #
    # I think this is for now O.K. behaviour, but I will leave this if block
    # here until I am 100% sure that "Exec Format Error" can be deprecated.
    if submission.status == Status.boxerr &&
       (
         submission.message.to_s.match(/^execve\(.+\): Exec format error$/) ||
         submission.message.to_s.match(/^execve\(.+\): No such file or directory$/) ||
         submission.message.to_s.match(/^execve\(.+\): Permission denied$/)
       )
       submission.status = Status.exeerr
    end
  end

  def cleanup(raise_exception = true)
    fix_permissions
    `sudo rm -rf #{boxdir}/* #{tmpdir}/*`
    [stdin_file, stdout_file, stderr_file, metadata_file].each do |f|
      `sudo rm -rf #{f}`
    end
    `isolate #{cgroups} -b #{box_id} --cleanup`
    raise "Cleanup of sandbox #{box_id} failed." if raise_exception && Dir.exists?(workdir)
  end

  def reset_metadata_file
    `sudo rm -rf #{metadata_file}`
    initialize_file(metadata_file)
  end

  def fix_permissions
    `sudo chown -R $(whoami): #{boxdir}`
  end

  def call_callback
    return unless submission.callback_url.present?

    serialized_submission = ActiveModelSerializers::SerializableResource.new(
      submission,
      {
        serializer: SubmissionSerializer,
        base64_encoded: true,
        fields: SubmissionSerializer.default_fields
      }
    ).to_json

    Config::CALLBACKS_MAX_TRIES.times do
      begin
        response = HTTParty.put(
          submission.callback_url,
          body: serialized_submission,
          headers: {
            "Content-Type" => "application/json"
          },
          timeout: Config::CALLBACKS_TIMEOUT
        )
        break
      rescue Exception => e
      end
    end
  rescue Exception => e
  end

  def get_metadata
    metadata = File.read(metadata_file).split("\n").collect do |e|
      { e.split(":").first.to_sym => e.split(":")[1..-1].join(":") }
    end.reduce({}, :merge)
    return metadata
  end

  def determine_status(status, exit_signal)
    if status == "TO"
      return Status.tle
    elsif status == "SG"
      return Status.find_runtime_error_by_status_code(exit_signal)
    elsif status == "RE"
      return Status.nzec
    elsif status == "XX"
      return Status.boxerr
    elsif submission.expected_output.nil? || strip(submission.expected_output) == strip(submission.stdout)
      return Status.ac
    else
      return Status.wa
    end
  end

  def strip(text)
    return nil unless text
    text.split("\n").collect(&:rstrip).join("\n").rstrip
  rescue ArgumentError
    return text
  end
end
