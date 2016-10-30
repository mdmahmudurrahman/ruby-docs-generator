# frozen_string_literal: true
user = User.create email: 'user@example.com', password: '123456'

Document.create ({
  user: user,

  discipline_code: '3.7.',
  specialization_name: '-',
  field_of_study_code: '6.040301',
  faculty_name: 'прикладної математики',
  discipline_name: "Комп'ютерні мережі",
  speciality_name: 'Прикладна математика',
  field_of_study_name: 'Прикладна математика',

  labs_count: '1',
  credits_count: '2',
  lectures_count: '3',
  semester_number: '4',
  type_of_control: '5',
  year_of_studying: '6',
  self_hours_count: '7',
  total_hours_count: '8'
})
