# frozen_string_literal: true

%i(faculty_name
   field_of_study
   discipline_code
   discipline_name
   speciality_name
   field_of_study_code
   field_of_study_name
   specialization_name
   formatted_faculty_name
   formatted_field_of_study
   formatted_speciality_name
   formatted_specialization_name

   labs_time
   credits_count
   lectures_time
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
    json.lectures_time sub_module.lectures_time
    json.labs_time sub_module.labs_time
    json.name sub_module.name

    topic_counter = 0
    topic_labs_time = sub_module.labs_time * 1.0 / sub_module.topics.count
    topic_lectures_time = sub_module.lectures_time * 1.0 / sub_module.topics.count

    json.topics sub_module.topics do |topic|
      json.name_prefix topic.name_prefix topic_counter += 1
      json.lectures_time topic_lectures_time
      json.labs_time topic_labs_time
      json.name topic.name
    end
  end
end

json.scientists document.scientists do |scientist|
  json.name scientist.name
  json.position scientist.position
end
