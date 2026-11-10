require 'rails_helper'

RSpec.describe CommandArguments do
  describe '.sanitize' do
    it 'strips leading and trailing whitespace' do
      expect(described_class.sanitize("  --hello  ")).to eq("--hello")
    end

    it 'removes dangerous characters' do
      dangerous = "$&;<>|`\\\n\r"
      dangerous.chars.each do |char|
        input = "--a#{char}b"
        expect(described_class.sanitize(input)).to eq("--ab")
      end
    end

    it 'replaces invalid UTF-8 sequences with replacement character' do
      invalid_utf8 = "valid\xFFinvalid".force_encoding("UTF-8")
      expect(described_class.sanitize(invalid_utf8)).to eq("validinvalid")
    end

    it 'returns an empty string when given nil' do
      expect(described_class.sanitize(nil)).to eq("")
    end

    it 'does not remove safe characters' do
      safe_string = "--abc123_-./ -option  -I../a/b"
      expect(described_class.sanitize(safe_string)).to eq(safe_string)
    end
  end
end
