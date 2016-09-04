FactoryGirl.define do
  factory :valid_submission, class: Submission do
    source_code 'name = gets.strip; puts "hello, " + name'
    language_id 14
    input "world"
    expected_output "hello, world"
  end

  factory :submission, parent: :valid_submission do
    actual_output "hello, world"
    status_id 1
  end

  factory :invalid_submission, class: Submission do
    source_code 'name = gets.strip; puts "hello, " + name'
    # language_id 14 # :language_id should be present
    input "world"
    expected_output "hello, world"
  end
end
