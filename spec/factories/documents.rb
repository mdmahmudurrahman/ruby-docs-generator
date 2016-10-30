FactoryGirl.define do
  factory :document do
    user

    number = Proc.new { Faker::Number.digit }
    name = Proc.new { Faker::University.name }
    code = Proc.new { Faker::Internet.ip_v4_address }

    %i(discipline_code field_of_study_code).each { |field| send field, &code }

    %i(discipline_name field_of_study_name speciality_name specialization_name
       faculty_name type_of_control).each { |field| send field, &name }

    %i(labs_count credits_count lectures_count semester_number year_of_studying
       self_hours_count total_hours_count).each { |field| send field, &number }
  end
end
