FactoryGirl.define do
  factory :language do
    sequence(:name) { |n| "C (gcc #{n})" }
    run_cmd './a.out'
    source_file 'main.c'
  end
end
