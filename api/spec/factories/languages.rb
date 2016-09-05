FactoryGirl.define do
  factory :language do
    sequence(:name) { |n| "C (gcc #{n})" }
    sequence(:compile_cmd) { |n| "gcc-#{n}"}
    source_file 'main.c'
  end
end
