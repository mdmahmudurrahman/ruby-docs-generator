# frozen_string_literal: true

%i(faculty_name
   field_of_study
   discipline_code
   discipline_name
   speciality_name
   field_of_study_code
   field_of_study_name
   specialization_name

   labs_count
   credits_count
   lectures_count
   semester_number
   type_of_control
   year_of_studying
   self_hours_count
   total_hours_count).each do |field|

  eval "json.#{field} document.send field"
end

main_module_counter = 0

json.main_modules document.main_modules do |main_module|
  json.name_prefix main_module.name_prefix main_module_counter += 1
  json.name main_module.name

  sub_module_counter = 0

  json.sub_modules main_module.sub_modules do |sub_module|
    json.name_prefix sub_module.name_prefix sub_module_counter += 1
    json.table_label sub_module.table_label sub_module_counter
    json.name sub_module.name

    topic_counter = 0

    json.topics sub_module.topics do |topic|
      json.name_prefix topic.name_prefix topic_counter += 1
      json.name topic.name
    end
  end
end
