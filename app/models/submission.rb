# == Schema Information
#
# Table name: submissions
#
#  id                                         :integer          not null, primary key
#  source_code                                :text
#  language_id                                :integer
#  stdin                                      :text
#  expected_output                            :text
#  stdout                                     :text
#  status_id                                  :integer
#  created_at                                 :datetime
#  finished_at                                :datetime
#  time                                       :decimal(, )
#  memory                                     :integer
#  stderr                                     :text
#  token                                      :string
#  number_of_runs                             :integer
#  cpu_time_limit                             :decimal(, )
#  cpu_extra_time                             :decimal(, )
#  wall_time_limit                            :decimal(, )
#  memory_limit                               :integer
#  stack_limit                                :integer
#  max_processes_and_or_threads               :integer
#  enable_per_process_and_thread_time_limit   :boolean
#  enable_per_process_and_thread_memory_limit :boolean
#  max_file_size                              :integer
#  compile_output                             :text
#  exit_code                                  :integer
#  exit_signal                                :integer
#  message                                    :text
#  wall_time                                  :decimal(, )
#
# Indexes
#
#  index_submissions_on_token  (token)
#

class Submission < ApplicationRecord
  validates :source_code, :language_id, presence: true
  validates :number_of_runs,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_NUMBER_OF_RUNS }
  validates :cpu_time_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_CPU_TIME_LIMIT }
  validates :cpu_extra_time,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_CPU_EXTRA_TIME }
  validates :wall_time_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_WALL_TIME_LIMIT }
  validates :memory_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_MEMORY_LIMIT }
  validates :stack_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_STACK_LIMIT }
  validates :max_processes_and_or_threads,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_MAX_PROCESSES_AND_OR_THREADS }
  validates :enable_per_process_and_thread_time_limit,
            inclusion: { in: [false], message: "this option cannot be enabled" },
            unless: "Config::ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT"
  validates :enable_per_process_and_thread_memory_limit,
            inclusion: { in: [false], message: "this option cannot be enabled" },
            unless: "Config::ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT"
  validates :max_file_size,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_MAX_FILE_SIZE }
  validate :language_existence

  before_create :generate_token
  before_validation :set_defaults

  enumeration :status

  default_scope { order(created_at: :desc) }

  self.per_page = 20

  def source_code
    return nil if super.nil?
    @decoded_source_code ||= Base64.decode64(self[:source_code]).force_encoding("UTF-8").encode
  end

  def source_code=(value)
    super(value)
    self[:source_code] = Base64.encode64(self[:source_code]) if self[:source_code]
  end
  

  def stdin
    return nil if super.nil?
    @decoded_stdin ||= Base64.decode64(self[:stdin]).force_encoding("UTF-8").encode
  end

  def stdin=(value)
    super(value)
    self[:stdin] = Base64.encode64(self[:stdin]) if self[:stdin]
  end
  

  def stdout
    return nil if super.nil?
    @decoded_stdout ||= Base64.decode64(self[:stdout]).force_encoding("UTF-8").encode
  end
  
  def stdout=(value)
    super(value)
    self[:stdout] = Base64.encode64(self[:stdout]) if self[:stdout]
  end
  

  def expected_output
    return nil if super.nil?
    @decoded_expected_output ||= Base64.decode64(self[:expected_output]).force_encoding("UTF-8").encode
  end

  def expected_output=(value)
    super(value)
    self[:expected_output] = Base64.encode64(self[:expected_output]) if self[:expected_output]
  end
  

  def stderr
    return nil if super.nil?
    @decoded_stderr ||= Base64.decode64(self[:stderr]).force_encoding("UTF-8").encode
  end
  
  def stderr=(value)
    super(value)
    self[:stderr] = Base64.encode64(self[:stderr]) if self[:stderr]
  end
  

  def compile_output
    return nil if super.nil?
    @decoded_compile_output ||= Base64.decode64(self[:compile_output]).force_encoding("UTF-8").encode
  end

  def compile_output=(value)
    super(value)
    self[:compile_output] = Base64.encode64(self[:compile_output]) if self[:compile_output]
  end

  
  def language
    @language ||= Language.find(language_id)
  end

  private

  def language_existence
    if language_id && Language.find_by_id(language_id).nil?
      errors.add(:language_id, "language with id #{language_id} doesn't exist")
    end
  end

  def generate_token
    begin
      self.token = SecureRandom.uuid
    end while self.class.exists?(token: token)
  end

  def set_defaults
    self.status ||= Status.queue
    self.number_of_runs ||= Config::NUMBER_OF_RUNS
    self.cpu_time_limit ||= Config::CPU_TIME_LIMIT
    self.cpu_extra_time ||= Config::CPU_EXTRA_TIME
    self.wall_time_limit ||= Config::WALL_TIME_LIMIT
    self.memory_limit ||= Config::MEMORY_LIMIT
    self.stack_limit ||= Config::STACK_LIMIT
    self.max_processes_and_or_threads ||= Config::MAX_MAX_PROCESSES_AND_OR_THREADS
    self.enable_per_process_and_thread_time_limit ||= Config::ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT
    self.enable_per_process_and_thread_memory_limit ||= Config::ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT
    self.max_file_size ||= Config::MAX_FILE_SIZE
  end
end
