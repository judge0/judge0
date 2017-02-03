require 'rails_helper'

RSpec.describe Submission, type: :model do
  it { should validate_presence_of(:source_code) }
  it { should validate_presence_of(:language_id) }
  it { validate_numericality_of(:number_of_runs).is_greater_than(0) }
  it { validate_numericality_of(:number_of_runs).only_integer }
  
  describe "#language" do
    let(:language) { create(:language) }

    it "returns language" do
      submission = create(:submission, { language_id: language.id })
      expect(submission.language).to eq(language)
    end
  end

  it "is invalid because Language with given id doesn't exist" do
    submission = build(:submission, { language_id: Language.all.size + 1 })
    expect(submission).not_to be_valid
  end

  it "is valid because Language with given id exists" do
    language = create(:language)
    submission = build(:submission, { language_id: language.id })
    expect(submission).to be_valid
  end
end
