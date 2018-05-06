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
#  source_id                                  :integer
#  stdin_id                                   :integer
#  stdout_id                                  :integer
#  stderr_id                                  :integer
#  expected_output_id                         :integer
#  compile_output_id                          :integer
#  message_id                                 :integer
#
# Indexes
#
#  index_submissions_on_token  (token)
#

class Submission < ApplicationRecord
  validates :number_of_runs,
            numericality: { greater_than: 0, less_than_or_equal_to: Rails.configuration.api[:max_number_of_runs] }

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

  before_create     :generate_token
  before_validation :set_defaults, if: -> { new_record? }

  belongs_to :language,                                   optional: false
  belongs_to :source,          class_name: Document.name, optional: false
  belongs_to :stdin,           class_name: Document.name, optional: true
  belongs_to :stdout,          class_name: Document.name, optional: true
  belongs_to :stderr,          class_name: Document.name, optional: true
  belongs_to :expected_output, class_name: Document.name, optional: true
  belongs_to :compile_output,  class_name: Document.name, optional: true
  belongs_to :message,         class_name: Document.name, optional: true

  enumeration :status

  default_scope { order(created_at: :desc) }

  private

  def generate_token
    begin
      self.token = SecureRandom.uuid
    end while self.class.exists?(token: token)
  end

  def set_defaults
    self.status_id                                  ||= Status.queue
    self.number_of_runs                             ||= Rails.configuration.api[:number_of_runs]
    self.cpu_time_limit                             ||= Rails.configuration.api[:cpu_time_limit]
    self.cpu_extra_time                             ||= Rails.configuration.api[:cpu_extra_time]
    self.wall_time_limit                            ||= Rails.configuration.api[:wall_time_limit]
    self.memory_limit                               ||= Rails.configuration.api[:memory_limit] 
    self.stack_limit                                ||= Rails.configuration.api[:stack_limit] 
    self.max_processes_and_or_threads               ||= Rails.configuration.api[:max_processes_and_or_threads] 
    self.enable_per_process_and_thread_time_limit   ||= Rails.configuration.api[:enable_per_process_and_thread_time_limit]
    self.enable_per_process_and_thread_memory_limit ||= Rails.configuration.api[:enable_per_process_and_thread_memory_limit] 
    self.max_file_size                              ||= Rails.configuration.api[:max_file_size] 
  end
end
