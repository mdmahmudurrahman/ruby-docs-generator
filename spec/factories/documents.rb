# frozen_string_literal: true
FactoryGirl.define do
  factory :document do
    user

    number = -> { Faker::Number.digit }
    name = -> { Faker::University.name }
    code = -> { Faker::Internet.ip_v4_address }

    %i(discipline_code field_of_study_code).each { |field| send field, &code }

    %i(discipline_name field_of_study_name speciality_name specialization_name
       faculty_name type_of_control).each { |field| send field, &name }

    %i(labs_count credits_count lectures_count semester_number year_of_studying
       self_hours_count total_hours_count).each { |field| send field, &number }

    factory :document_with_main_modules do
      transient { main_modules_count 3 }

      before(:create) do |document, evaluator|
        count = evaluator.main_modules_count
        create_list :main_module, count, document: document
      end
    end
  end
end
