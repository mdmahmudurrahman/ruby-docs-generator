# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    factory :user_with_documents do
      transient { documents_count 3 }

      before(:create) do |user, evaluator|
        count = evaluator.documents_count
        create_list :document, count, user: user
      end
    end
  end
end
