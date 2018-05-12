# == Schema Information
#
# Table name: submission_results
#
#  id                  :bigint(8)        not null, primary key
#  submission_id       :bigint(8)        not null
#  test_case_id        :bigint(8)        not null
#  stdout_id           :bigint(8)
#  stderr_id           :bigint(8)
#  compile_output_id   :bigint(8)
#  sandbox_message_id  :bigint(8)
#  internal_message_id :bigint(8)
#  time                :decimal(, )
#  wall_time           :decimal(, )
#  memory              :integer
#  exit_code           :integer
#  exit_signal         :integer
#  status_id           :integer
#  index               :integer
#  created_at          :datetime
#  finished_at         :datetime
#
# Indexes
#
#  index_submission_results_on_compile_output_id               (compile_output_id)
#  index_submission_results_on_internal_message_id             (internal_message_id)
#  index_submission_results_on_sandbox_message_id              (sandbox_message_id)
#  index_submission_results_on_stderr_id                       (stderr_id)
#  index_submission_results_on_stdout_id                       (stdout_id)
#  index_submission_results_on_submission_id                   (submission_id)
#  index_submission_results_on_submission_id_and_test_case_id  (submission_id,test_case_id)
#  index_submission_results_on_test_case_id                    (test_case_id)
#

class SubmissionResult < ApplicationRecord
  validates :index, presence: true

  before_validation :set_defaults, if: -> { new_record? }

  belongs_to :submission, optional: false, inverse_of: :results
  belongs_to :test_case,  optional: false

  belongs_to :stdout,           class_name: Document.name, optional: true
  belongs_to :stderr,           class_name: Document.name, optional: true
  belongs_to :compile_output,   class_name: Document.name, optional: true
  belongs_to :sandbox_message,  class_name: Document.name, optional: true
  belongs_to :internal_message, class_name: Document.name, optional: true

  def status
    Status.find_by(id: status_id)
  end

  def status=(status)
    self.status_id = status.try(:integer) ? status : status.id
  end

  private

  def set_defaults
    self.status ||= Status.queue
  end
end
