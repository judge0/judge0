require 'rails_helper'

RSpec.describe Language, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:run_cmd) }
  it { should validate_presence_of(:source_file) }
end
