# frozen_string_literal: true
FactoryGirl.define do
  factory :topic do
    sub_module

    name { Faker::University.name }
    labs_time { Faker::Number.digit }
    lectures_time { Faker::Number.digit }
  end
end
