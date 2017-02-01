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
#

class Submission < ApplicationRecord
  validates :source_code, :language_id, presence: true
  validate :language_existence
  enumeration :status

  def language
    @language ||= Language.find(language_id)
  end

  def language_existence
    if language_id && Language.find_by_id(language_id).nil?
      errors.add(:language_id, "language with id #{language_id} doesn't exist")
    end
  end
end
