# frozen_string_literal: true
FactoryGirl.define do
  factory :topic do
    sub_module
    name { Faker::University.name }
    position { Faker::Number.digit }
  end
end
