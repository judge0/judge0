# == Schema Information
#
# Table name: submissions
#
#  id              :integer          not null, primary key
#  source_code     :text
#  language_id     :integer
#  input           :text
#  expected_output :text
#  actual_output   :text
#  status_id       :integer
#  created_at      :datetime
#  finished_at     :datetime
#

class Submission < ApplicationRecord
  validates :source_code, :language_id, presence: true
  enumeration :status

  def language
    @language ||= Language.find(language_id)
  end
end
