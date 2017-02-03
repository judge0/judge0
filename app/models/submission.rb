# == Schema Information
#
# Table name: submissions
#
#  id              :integer          not null, primary key
#  source_code     :text
#  language_id     :integer
#  input           :text
#  expected_output :text
#  stdout          :text
#  status_id       :integer
#  created_at      :datetime
#  finished_at     :datetime
#  time            :decimal(, )
#  memory          :integer
#  stderr          :text
#  token           :string
#  number_of_runs  :integer
#
# Indexes
#
#  index_submissions_on_token  (token)
#

class Submission < ApplicationRecord
  validates :source_code, :language_id, presence: true
  validates :number_of_runs, numericality: { greater_than: 0, only_integer: true }
  validate :language_existence

  before_create :generate_token
  before_save :set_defaults

  enumeration :status

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
    self.status ||= Status.in_queue
    self.number_of_runs ||= 1
  end
end
