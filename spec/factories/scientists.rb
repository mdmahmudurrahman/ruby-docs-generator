# frozen_string_literal: true
FactoryGirl.define do
  factory :scientist do
    document
    name { Faker::Name.name }
    position { Faker::Name.name }
  end
end
