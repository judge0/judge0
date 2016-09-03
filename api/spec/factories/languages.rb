FactoryGirl.define do
  factory :language do
    sequence(:name) { |n| "C (gcc #{n})" }
    sequence(:compile_cmd) { |n| "gcc-#{n}"}
  end
end
