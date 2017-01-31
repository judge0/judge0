class IsolateJob < ApplicationJob
  queue_as :default

  # https://raw.githubusercontent.com/ioi/isolate/master/isolate.1.txt
  CPU_TIME_LIMIT = ENV['CPU_TIME_LIMIT'].presence || 1
  CPU_EXTRA_TIME = ENV['CPU_EXTRA_TIME'].presence || 0.5
  WALL_TIME_LIMIT = ENV['WALL_TIME_LIMIT'].presence || 3
  MEMORY_LIMIT = ENV['MEM_LIMIT'].presence || 256000 # in KB
  STACK_LIMIT = ENV['STACK_LIMIT'].presence || 256000 # in KB
  MAX_PROCESSES_AND_OR_THREADS = ENV['MAX_PROCESSES_AND_OR_THREADS'].presence || 15
  ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT'].present? ? '' : '--cg-timing'
  ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT = ENV['ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT'].present?
  MAX_FILE_SIZE = ENV['MAX_FILE_SIZE'].presence || 1

  STDIN_FILE = 'stdin.txt'
  STDOUT_FILE = 'stdout.txt'
  STDERR_FILE = 'stderr.txt'
  META_FILE = 'meta.txt'

  attr_reader :submission, :workdir, :box, :source, :stdin, :stdout, :stderr,
              :meta, :parsed_meta, :id

  def perform(submission)
    @submission = submission
    init
    write
    run if compile == :success
    verify
  rescue Exception => e
    @submission.update(output: e.message, status: Status.boxerr)
  ensure
    clean
  end

  private

  def init
    @id = submission.id%2147483647
    @workdir = `isolate --cg -b #{id} --init`.chomp
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

    submission.update(output: errors, status: Status.ce)
    :failure
  end

  def run
    `isolate --cg \
    #{Rails.env.development? ? '-v' : ''} \
    -b #{id} \
    -i #{STDIN_FILE} \
    -o #{STDOUT_FILE} \
    -r #{STDERR_FILE} \
    -M #{meta} \
    -t #{CPU_TIME_LIMIT} \
    -x #{CPU_EXTRA_TIME} \
    -w #{WALL_TIME_LIMIT} \
    -k #{STACK_LIMIT} \
    -p#{MAX_PROCESSES_AND_OR_THREADS} \
    #{ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT ? "-m " : "--cg-mem="}#{MEMORY_LIMIT} \
    #{ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT} \
    -f #{MAX_FILE_SIZE} \
    -E HOME=#{workdir} \
    -d '/etc':'noexec' \
    --run \
    -- #{submission.language.run_cmd}`
  end

  def verify
    change_permissions
    parse_meta
    submission.time = parsed_meta["time"].to_f
    submission.memory = parsed_meta["cg-mem"].to_i
    submission.output = File.read(stdout)
    submission.status = determine_status
    submission.finished_at = DateTime.now
    if !submission.status.ac? && !submission.status.wa?
      preappend = submission.output.present? ? "\n" : ""
      submission.output += preappend + File.read(stderr)
      if submission.status.boxerr?
        preappend = submission.output.present? ? "\n" : ""
        submission.output += preappend + parsed_meta["message"]
      end
    end
    submission.save
  end

  def clean
    `isolate --cg -b #{id} --cleanup`
  end
  
  def change_permissions
    `sudo chown $(whoami): #{box} #{meta} #{stdout} #{stderr}` 
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
    elsif submission.expected_output.nil? || strip_output(submission.expected_output) == strip_output(submission.output)
      return Status.ac
    else
      return Status.wa
    end
  end

  def strip_output(output)
    output.split("\n").collect(&:rstrip).join("\n").rstrip
  end
end
