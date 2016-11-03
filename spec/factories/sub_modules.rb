# frozen_string_literal: true
FactoryGirl.define do
  factory :sub_module do
    main_module

    name { Faker::University.name }
    labs_count { Faker::Number.digit }
    lectures_count { Faker::Number.digit }
  end
end
