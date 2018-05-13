# == Schema Information
#
# Table name: submissions
#
#  id                                         :integer          not null, primary key
#  language_id                                :integer
#  status_id                                  :integer
#  created_at                                 :datetime
#  finished_at                                :datetime
#  uuid                                       :string
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
#  source_id                                  :bigint(8)
#  test_suite_id                              :bigint(8)
#  compile_output_id                          :bigint(8)
#  internal_message_id                        :bigint(8)
#
# Indexes
#
#  index_submissions_on_compile_output_id    (compile_output_id)
#  index_submissions_on_internal_message_id  (internal_message_id)
#  index_submissions_on_source_id            (source_id)
#  index_submissions_on_test_suite_id        (test_suite_id)
#  index_submissions_on_uuid                 (uuid)
#

class Submission < ApplicationRecord
  validates :cpu_time_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_cpu_time_limit] }

  validates :cpu_extra_time,
           numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_cpu_extra_time] }

  validates :wall_time_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_wall_time_limit] }

  validates :memory_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_memory_limit] }

  validates :stack_limit,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_stack_limit] }

  validates :max_processes_and_or_threads,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_max_processes_and_or_threads] }

  validates :enable_per_process_and_thread_time_limit,
            inclusion: { in: [false], message: "this option cannot be enabled" },
            unless: -> { Rails.configuration.api[:allow_enable_per_process_and_thread_time_limit] }

  validates :enable_per_process_and_thread_memory_limit,
            inclusion: { in: [false], message: "this option cannot be enabled" },
            unless: -> { Rails.configuration.api[:allow_enable_per_process_and_thread_memory_limit] }

  validates :max_file_size,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_max_file_size] }

  validates :number_of_runs,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_number_of_runs] }

  before_create     :generate_uuid
  before_validation :set_defaults, if: -> { new_record? }

  belongs_to :language,   optional: false
  belongs_to :test_suite, optional: false

  belongs_to :source,           class_name: Document.name, optional: false
  belongs_to :compile_output,   class_name: Document.name, optional: true
  belongs_to :internal_message, class_name: Document.name, optional: true

  has_many :results, -> { order(index: :asc) }, class_name: SubmissionResult.name, inverse_of: :submission

  default_scope { order(created_at: :desc) }

  def status
    Status.find_by(id: status_id)
  end

  def status=(status)
    self.status_id = status.try(:integer) ? status : status.id
  end

  private

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists?(uuid: uuid)
  end

  def set_defaults
    self.status                                     ||= Status.queue
    self.cpu_time_limit                             ||= Rails.configuration.api[:cpu_time_limit]
    self.cpu_extra_time                             ||= Rails.configuration.api[:cpu_extra_time]
    self.wall_time_limit                            ||= Rails.configuration.api[:wall_time_limit]
    self.memory_limit                               ||= Rails.configuration.api[:memory_limit]
    self.stack_limit                                ||= Rails.configuration.api[:stack_limit]
    self.max_processes_and_or_threads               ||= Rails.configuration.api[:max_processes_and_or_threads]
    self.enable_per_process_and_thread_time_limit   ||= Rails.configuration.api[:enable_per_process_and_thread_time_limit]
    self.enable_per_process_and_thread_memory_limit ||= Rails.configuration.api[:enable_per_process_and_thread_memory_limit]
    self.max_file_size                              ||= Rails.configuration.api[:max_file_size]
    self.number_of_runs                             ||= Rails.configuration.api[:number_of_runs]
  end
end
