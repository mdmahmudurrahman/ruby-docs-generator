FactoryGirl.define do
  factory :topic do
    sub_module
    
    name { Faker::University.name }
    labs_count { Faker::Number.digit }
    lecture_count { Faker::Number.digit }
  end
end
