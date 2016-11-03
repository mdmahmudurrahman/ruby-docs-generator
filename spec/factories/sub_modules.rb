# frozen_string_literal: true
FactoryGirl.define do
  factory :sub_module do
    main_module

    name { Faker::University.name }
    position { Faker::Number.digit }
    labs_time { Faker::Number.digit }
    lectures_time { Faker::Number.digit }

    factory :sub_module_with_topics do
      transient { topics_count 3 }

      before(:create) do |sub_module, evaluator|
        count = evaluator.topics_count
        create_list :topic, count, sub_module: sub_module
      end
    end
  end
end
