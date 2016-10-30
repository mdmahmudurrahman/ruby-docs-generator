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
