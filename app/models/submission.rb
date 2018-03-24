# == Schema Information
#
# Table name: submissions
#
#  id                                         :integer          not null, primary key
#  language_id                                :integer
#  status_id                                  :integer
#  created_at                                 :datetime
#  finished_at                                :datetime
#  time                                       :decimal(, )
#  memory                                     :integer
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
#  exit_code                                  :integer
#  exit_signal                                :integer
#  wall_time                                  :decimal(, )
#  source_digest                              :string
#  stdin_digest                               :string
#  stdout_digest                              :string
#  stderr_digest                              :string
#  expected_output_digest                     :string
#  compile_output_digest                      :string
#  message_digest                             :string
#
# Indexes
#
#  index_submissions_on_token  (token)
#

class Submission < ApplicationRecord
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
            unless: -> { Config::ALLOW_ENABLE_PER_PROCESS_AND_THREAD_TIME_LIMIT }
  validates :enable_per_process_and_thread_memory_limit,
            inclusion: { in: [false], message: "this option cannot be enabled" },
            unless: -> { Config::ALLOW_ENABLE_PER_PROCESS_AND_THREAD_MEMORY_LIMIT }
  validates :max_file_size,
            numericality: { greater_than: 0, less_than_or_equal_to: Config::MAX_MAX_FILE_SIZE }

  before_create :generate_token
  before_validation :set_defaults

  belongs_to :language, optional: false

  belongs_to :source,          class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "source_"          + Document.primary_key, optional: false
  belongs_to :stdin,           class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "stdin_"           + Document.primary_key, optional: true
  belongs_to :stdout,          class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "stdout_"          + Document.primary_key, optional: true
  belongs_to :stderr,          class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "stderr_"          + Document.primary_key, optional: true
  belongs_to :expected_output, class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "expected_output_" + Document.primary_key, optional: true
  belongs_to :compile_output,  class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "compile_output_"  + Document.primary_key, optional: true
  belongs_to :message,         class_name: Document.to_s, primary_key: Document.primary_key, foreign_key: "message_"         + Document.primary_key, optional: true

  enumeration :status

  default_scope { order(created_at: :desc) }

  self.per_page = 20

  private

  def generate_token
    begin
      self.token = SecureRandom.uuid
    end while self.class.exists?(token: token)
  end

  def set_defaults
    self.status_id ||= Status.queue
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
