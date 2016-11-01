FactoryGirl.define do
  factory :main_module do
    document
    name { Faker::Name.name }
    total_time { Faker::Number.digit }
  end
end
