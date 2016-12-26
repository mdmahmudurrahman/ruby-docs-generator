# frozen_string_literal: true

user = User.first_or_create email: 'user@example.com', password: '123456'

document = Document.first_or_create user: user,
                                    discipline_code: '3.7',
                                    discipline_name: "Комп'ютерні мережі",
                                    field_of_study_code: '6.040301',
                                    field_of_study_name: 'Прикладна математика',
                                    speciality_name: 'Прикладна математика',
                                    specialization_name: '',
                                    faculty_name: 'прикладної математики',
                                    type_of_control: 'залiк',
                                    credits_count: '4',
                                    labs_time: '18',
                                    lectures_time: '18',
                                    semester_number: '5',
                                    year_of_studying: '3',
                                    self_hours_count: '108',
                                    total_hours_count: '144',
                                    cathedra_name: 'Математичного забезпечення ЕОМ',
                                    groups_codes: 'ПМ–13–1, ПМ-13-2, ПМ-13-3',
                                    head_of_department: 'Байбуз О.Г.', program_department_approved_date: '“19” травня 2015 року № 11',
                                    head_of_commission: 'Ламзюк В.Д.', program_commission_approved_date: '“16” червня 2015 року № 14',
                                    head_of_academic_council: 'Кісельова О.М.', program_academic_council_approved_date: '“18” червня 2015 року № 9'

main_module = MainModule.first_or_create name: 'Комп’ютерні мережі',
                                         document: document,
                                         total_time: 144

if main_module.sub_modules.empty?
  sub_module = SubModule.create name: 'Комп’ютерні мережі: поняття, проектування, використання',
                                labs_time: 8, lectures_time: 8, main_module: main_module

  topic_names = ['Основні поняття та терміни.Історія розвитку обчислювальних мереж.',
                 'Середовище передачі локальних мереж', 'Топології локальних мереж.',
                 'Робочі станшї та сервери мереж.']

  topic_names.each do |name|
    Topic.create name: name,
                 labs_time: 2,
                 lectures_time: 2,
                 sub_module: sub_module
  end

  sub_module = SubModule.create name: 'Розробка баз даних в режимі мережі',
                                labs_time: 10, lectures_time: 10,
                                main_module: main_module

  topic_names = ["Локальні комп'ютерні мережі.", 'Протоколи та стандарти мереж.',
                 'Програмне забезпечення мереж', 'Мережі INTERNET.',
                 'Базова модель OSІ.']

  topic_names.each do |name|
    Topic.create name: name,
                 labs_time: 2,
                 lectures_time: 2,
                 sub_module: sub_module
  end
end

if document.scientists.empty?
  Scientist.create name: 'Мащенко Л.В.',
                   document: document,
                   practician: true,
                   examiner: true

  Scientist.create name: 'Ризоль О.О.',
                   document: document,
                   practician: true
end

if Lab.count == 0
  labs = { 'Програмні та апаратні засоби комп’ютерних мереж': 4,
           'Програмування  мережевого додатку для роботи з ба-зами даних': 8,
           "Розробка простої комп'ютерної гри  для  двох  користувачів у локальній мережі": 6 }

  labs.each do |name, time|
    Lab.create name: name,
               time_count: time,
               document: document
  end
end
