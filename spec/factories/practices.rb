# frozen_string_literal: true
FactoryGirl.define do
  factory :practice do
    document
    name { Faker::Name.name }
    time_count 1
  end
end
