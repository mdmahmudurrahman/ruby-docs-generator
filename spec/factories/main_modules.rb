# frozen_string_literal: true
FactoryGirl.define do
  factory :main_module do
    document
    name { Faker::Name.name }
    total_time { Faker::Number.digit }

    factory :main_module_with_sub_modules do
      transient { main_modules_count 3 }

      before(:create) do |main_module, evaluator|
        count = evaluator.main_modules_count
        create_list :sub_module, count, main_module: main_module
      end
    end
  end
end
