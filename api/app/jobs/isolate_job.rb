class IsolateJob < ApplicationJob
  queue_as :default

  CPU_TIME_LIMIT = 1 # in seconds
  WALL_TIME_LIMIT = 1 # in seconds
  EXTRA_TIME = 0.5 # in seconds
  MEM_LIMIT = 256000 # in KB
  STACK_LIMIT = 8000 # in KB
  PROCESS_THREAD_LIMIT = 1

  STDIN_FILE = 'stdin.txt'
  STDOUT_FILE = 'stdout.txt'
  STDERR_FILE = 'stderr.txt'
  META_FILE = 'meta.txt'

  def perform(submission)
    @submission = submission
    init
    write
    run if compile == :success
    check
    cleanup
  end

  private

  def init
    @workdir = `isolate --init -b #{@submission.id}`.chomp
    @box = @workdir + "/box/"

    @source = @box + "#{@submission.language.source_file}"
    @stdin = @box + STDIN_FILE
    @stdout = @box + STDOUT_FILE
    @stderr = @box + STDERR_FILE
    @meta = @box + META_FILE
  end

  def write
    File.open(@source, 'w') { |f| f.write(@submission.source_code) }
    File.open(@stdin, 'w') { |f| f.write(@submission.input) }
  end

  def compile
    return :success unless @submission.language.compile_cmd

    errors = `cd #{@box} && #{@submission.language.compile_cmd} #{@source} 2>&1`
    unless $?.success?
      @submission.update(
        actual_output: errors.gsub(/^.*: /, ""),
        status: Status.ce
      )
      return :failure
    end
    :success
  end

  def run
    `isolate --run \
    -b #{@submission.id} \
    -i #{STDIN_FILE} \
    -o #{STDOUT_FILE} \
    -r #{STDERR_FILE} \
    -M #{@meta} \
    -t #{CPU_TIME_LIMIT} \
    -w #{WALL_TIME_LIMIT} \
    -x #{EXTRA_TIME} \
    -k #{STACK_LIMIT} \
    -m #{MEM_LIMIT} \
    -- #{@submission.language.run_cmd}`
  end

  def check
    parse_meta
    @submission.time = @parsed_meta["time"].to_f
    @submission.actual_output = File.read(@stdout)
    @submission.status = determine_status
    @submission.save
  end

  def cleanup
    `isolate --cleanup -b #{@submission.id}`
  end

  def parse_meta
    meta_content = File.read(@meta)
    @parsed_meta = meta_content.split("\n").collect do |e|
      { e.split(":").first => e.split(":").second }
    end.reduce({}, :merge)
  end

  def determine_status
    if @parsed_meta['status'] == 'TO'
      return Status.tle
    elsif @parsed_meta['status'] == 'SG'
      return Status.find_runtime_error_by_status_code(@parsed_meta['exitsig'])
    elsif @parsed_meta['status'] == 'RE'
      return Status.nzec
    elsif @parsed_meta['status'] == 'XX'
      return Status.sandbox
    elsif strip_output(@submission.expected_output) == strip_output(@submission.actual_output)
      return Status.ac
    else
      return Status.wa
    end
  end

  def strip_output(output)
    output.split("\n").collect(&:rstrip).join("\n").rstrip
  end
end
