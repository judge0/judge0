class IsolateJob < ApplicationJob
  queue_as :default

  STDIN_FILE = 'stdin.txt'
  STDOUT_FILE = 'stdout.txt'
  STDERR_FILE = 'stderr.txt'
  META_FILE = 'meta.txt'

  attr_reader :submission, :workdir, :box, :cgroups, :source, :stdin, :stdout, :stderr,
              :meta, :parsed_meta, :id

  def perform(submission)
    @submission = submission
    time = []
    memory = []

    submission.update(status: Status.process)
    submission.number_of_runs.times do
      init
      write
      if compile == :failure
        clean
        return
      end
      run
      verify

      time << submission.time
      memory << submission.memory

      clean
      break if submission.status != Status.ac
    end

    submission.time = time.inject(&:+).to_f / time.size
    submission.memory = memory.inject(&:+).to_f / memory.size
    submission.save

  rescue Exception => e
    submission.stderr = e.message
    submission.status = Status.boxerr
    submission.save
    clean
  end

  private

  def init
    @id = submission.id%2147483647
    @cgroups = (submission.enable_per_process_and_thread_time_limit | submission.enable_per_process_and_thread_memory_limit ? "--cg" : "")
    @workdir = `isolate #{cgroups} -b #{id} --init`.chomp
    @box = workdir + "/box/"

    @source = box + "#{submission.language.source_file}"
    @stdin = box + STDIN_FILE
    @stdout = box + STDOUT_FILE
    @stderr = box + STDERR_FILE
    @meta = box + META_FILE
  end

  def write
    File.open(source, 'w') { |f| f.write(submission.source_code) }
    File.open(stdin, 'w') { |f| f.write(submission.input) }
  end

  def compile
    return :success unless submission.language.compile_cmd

    errors = `cd #{box} && #{submission.language.compile_cmd} 2>&1`
    return :success if $?.success?

    submission.update(
      stderr: errors,
      status: Status.ce,
      finished_at: DateTime.now
    )
    :failure
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

    puts "[#{DateTime.now}] Running submission #{submission.token} (#{submission.id}):"
    puts command.gsub(/\s+/, " ")

    `#{command}`
  end

  def verify
    submission.finished_at = DateTime.now

    change_permissions
    parse_meta

    submission.time = parsed_meta["time"].to_f
    submission.memory = (cgroups == "" ? parsed_meta["max-rss"].to_i : parsed_meta["cg-mem"].to_i)
    submission.stdout = fix_encoding(File.read(stdout))
    submission.stderr = fix_encoding(File.read(stderr))

    submission.status = determine_status
    if submission.status.boxerr?
      preappend = submission.stderr.present? ? "\n" : ""
      submission.stderr += preappend + parsed_meta["message"]
    end
  end

  def clean
    `isolate #{cgroups} -b #{id} --cleanup`
  end

  def change_permissions
    `sudo chown $(whoami): #{box} #{meta} #{stdout} #{stderr}`
  end

  def fix_encoding(text)
    return text if text.valid_encoding?
    text.encode("UTF-16", invalid: :replace, replace: '?').encode("UTF-8")
  end

  def parse_meta
    meta_content = File.read(meta)
    @parsed_meta = meta_content.split("\n").collect do |e|
      { e.split(":").first => e.split(":")[1..-1].join(":") }
    end.reduce({}, :merge)
  end

  def determine_status
    if parsed_meta['status'] == 'TO'
      return Status.tle
    elsif parsed_meta['status'] == 'SG'
      return Status.find_runtime_error_by_status_code(parsed_meta['exitsig'])
    elsif parsed_meta['status'] == 'RE'
      return Status.nzec
    elsif parsed_meta['status'] == 'XX'
      return Status.boxerr
    elsif submission.expected_output.nil? || strip_output(submission.expected_output) == strip_output(submission.stdout)
      return Status.ac
    else
      return Status.wa
    end
  end

  def strip_output(output)
    output.split("\n").collect(&:rstrip).join("\n").rstrip
  end
end
