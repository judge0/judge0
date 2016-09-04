require 'rails_helper'

RSpec.describe Submission, type: :model do
  it { should validate_presence_of(:source_code) }
  it { should validate_presence_of(:language_id) }

  describe "#language" do
    let(:language) { create(:language) }

    it "returns language" do
      submission = create(:submission, { language_id: language.id })
      expect(submission.language).to eq(language)
    end

    it "raises an error because language doesn't exist" do
      submission = create(:submission, { language_id: Language.all.size + 1 })
      expect{ submission.language }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
