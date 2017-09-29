FactoryGirl.define do
  factory :valid_submission, class: Submission do
    sequence(:token) { |n| SecureRandom.uuid + "-#{n}" }
    source_code 'name = gets.strip; puts "hello, " + name'
    language_id { create(:language).id }
    number_of_runs 1
    stdin "world"
    expected_output "hello, world"
  end

  factory :submission, parent: :valid_submission do
    stdout "hello, world"
    status_id 1
    time 1.0
    memory 256
  end

  factory :invalid_submission, class: Submission do
    source_code 'name = gets.strip; puts "hello, " + name'
    # language_id 14 # :language_id should be present
    stdin "world"
    expected_output "hello, world"
  end
end
