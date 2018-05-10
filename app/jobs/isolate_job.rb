class IsolateJob < ApplicationJob
  queue_as :default

  STDIN_FILE  = 'stdin.txt'
  STDOUT_FILE = 'stdout.txt'
  STDERR_FILE = 'stderr.txt'
  META_FILE   = 'meta.txt'

  attr_reader :submission, :result, :workdir, :box, :cgroups, :source, :stdin, :stdout, :stderr,
              :meta, :parsed_meta, :id

  def perform(submission)
    @submission = submission

    init()
    write_source()
    compile_status = compile()
    unless compile_status[0]
      now = DateTime.now
      submission.submission_results.each do |result|
        result.update(
          finished_at: now,
          status: Status.ce,
          compile_output: Document.find_or_create_with_content(compile_status[1])
        )
      end
      clean()
      return
    end

    submission.submission_results.each do |result|
      @result = result

      result.update(status: Status.process)

      write_input()

      time   = []
      memory = []

      submission.number_of_runs.times do
        delete_stdout_stderr_and_meta_files()
        run()
        verify()

        time   << result.time
        memory << result.memory

        break if result.status != Status.ac
      end

      result.time   = time  .inject(&:+).to_f / time.size
      result.memory = memory.inject(&:+).to_f / memory.size
      result.save
    end

    clean()

  rescue Exception => e
    result.update(internal_message: Document.find_or_create_with_content(e.message), status: Status.boxerr)
    Rails.logger.debug "[#{DateTime.now}] Internal Error while processing submission #{submission.id} and result #{result.id}: #{e.message}"
    clean()
  end

  private

  def init
    @id      = submission.id%2147483647
    @cgroups = (submission.enable_per_process_and_thread_time_limit | submission.enable_per_process_and_thread_memory_limit ? "--cg" : "")
    @workdir = `isolate #{cgroups} -b #{id} --init`.chomp
    @box     = workdir + "/box/"
    @source  = box + submission.language.source_file
    @stdin   = box + STDIN_FILE
    @stdout  = box + STDOUT_FILE
    @stderr  = box + STDERR_FILE
    @meta    = box + META_FILE
  end

  def write_source
    File.open(source, 'w:UTF-8') { |f| f.write(submission.source.content) }
  end

  def write_input
    File.open(stdin, 'w:UTF-8') { |f| f.write(result.test_case.input.try(:content)) }
  end

  def compile
    return [true, nil] unless submission.language.compile_cmd

    compile_output = `cd #{box} && #{submission.language.compile_cmd} 2>&1`.presence
    return [$?.success?, compile_output]
  end

  def run
    command = "isolate #{cgroups} \
    #{Rails.env.development? ? '-v' : ''} \
    -b #{id} \
    -i #{STDIN_FILE} \
    -o #{STDOUT_FILE} \
    -r #{STDERR_FILE} \
    -M #{meta} \
    -t #{submission.cpu_time_limit} \
    -x #{submission.cpu_extra_time} \
    -w #{submission.wall_time_limit} \
    -k #{submission.stack_limit} \
    -p#{submission.max_processes_and_or_threads} \
    #{submission.enable_per_process_and_thread_memory_limit ? "--cg-mem=" : "-m "}#{submission.memory_limit} \
    #{submission.enable_per_process_and_thread_time_limit ? "--cg-timing" : ""} \
    -f #{submission.max_file_size} \
    -E HOME=#{workdir} \
    -d '/etc':'noexec' \
    --run \
    -- #{submission.language.run_cmd}"

    Rails.logger.debug "[#{DateTime.now}] Running submission #{submission.token} (#{submission.id}):"
    Rails.logger.debug command.gsub(/\s+/, " ")

    `#{command}`
  end

  def verify
    result.finished_at = DateTime.now

    change_permissions()
    parse_meta()

    program_stdout = File.read(stdout)
    program_stderr = File.read(stderr)

    program_stdout = nil if program_stdout.empty?
    program_stderr = nil if program_stderr.empty?

    sandbox_message = parsed_meta[:message] || ""
    sandbox_message = nil if sandbox_message.empty?

    result.time            = parsed_meta[:time]
    result.wall_time       = parsed_meta[:"time-wall"]
    result.memory          = (cgroups.present? ? parsed_meta[:"cg-mem"] : parsed_meta[:"max-rss"])
    result.stdout          = Document.find_or_create_with_content(program_stdout)
    result.stderr          = Document.find_or_create_with_content(program_stderr)
    result.exit_code       = parsed_meta[:exitcode].try(:to_i) || 0
    result.exit_signal     = parsed_meta[:exitsig].try(:to_i)
    result.sandbox_message = Document.find_or_create_with_content(sandbox_message)
    result.status          = determine_status
  end

  def clean
    `isolate #{cgroups} -b #{id} --cleanup`
  end

  def delete_stdout_stderr_and_meta_files
    File.delete(stdout)
    File.delete(stderr)
    File.delete(meta)
  rescue Errno::ENOENT => ignorable
  end

  def change_permissions
    `sudo chown $(whoami): #{box} #{meta} #{stdout} #{stderr}`
  end

  def parse_meta
    meta_content = File.read(meta)
    @parsed_meta = meta_content.split("\n").collect do |e|
      { e.split(":").first.to_sym => e.split(":")[1..-1].join(":") }
    end.reduce({}, :merge)
  end

  def determine_status
    if parsed_meta[:status] == 'TO'
      return Status.tle
    elsif parsed_meta[:status] == 'SG'
      return Status.find_runtime_error_by_status_code(parsed_meta[:exitsig])
    elsif parsed_meta[:status] == 'RE'
      return Status.nzec
    elsif parsed_meta[:status] == 'XX'
      return Status.boxerr
    elsif result.test_case.output.try(:id).nil? ||
          strip_output(result.test_case.output.try(:content)) == strip_output(result.stdout.try(:content))
      return Status.ac
    else
      return Status.wa
    end
  end

  def strip_output(output)
    return nil unless output
    output.split("\n").collect(&:rstrip).join("\n").rstrip
  end
end
