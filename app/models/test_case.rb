# == Schema Information
#
# Table name: test_cases
#
#  id         :bigint(8)        not null, primary key
#  uuid       :string           not null
#  input_id   :bigint(8)
#  output_id  :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_test_cases_on_input_id   (input_id)
#  index_test_cases_on_output_id  (output_id)
#  index_test_cases_on_uuid       (uuid) UNIQUE
#

class TestCase < ApplicationRecord
  validates :input,  uniqueness: { scope: :output }
  validates :output, uniqueness: { scope: :input  }

  belongs_to :input,  class_name: Document.to_s, optional: true
  belongs_to :output, class_name: Document.to_s, optional: true

  before_create :generate_uuid

  attr_accessor :index

  def readonly?
    !new_record?
  end

  private

  def generate_uuid
    begin
      self.uuid = SecureRandom.uuid
    end while self.class.exists?(uuid: uuid)
  end
end
