# == Schema Information
#
# Table name: test_suites
#
#  id            :bigint(8)        not null, primary key
#  uuid          :string           not null
#  test_case_ids :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_test_suites_on_test_case_ids  (test_case_ids) UNIQUE
#  index_test_suites_on_uuid           (uuid) UNIQUE
#

class TestSuite < ApplicationRecord
  validates :test_case_ids, presence: true
  validates :test_case_ids, uniqueness: true

  before_create :generate_uuid

  attr :test_cases

  def test_cases
    @test_cases ||= TestCase.find(test_case_ids.split(",").map(&:to_i))
  end
  
  def test_cases=(test_cases)
    @test_cases = test_cases
    self.test_case_ids = test_cases.pluck(:id).sort.map(&:to_s).join(",")
  end

  private

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists?(uuid: uuid)
  end
end
