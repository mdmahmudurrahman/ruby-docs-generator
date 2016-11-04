# frozen_string_literal: true
class DocumentDecorator < Draper::Decorator
  delegate_all

  decorates_association :main_modules

  def field_of_study
    "#{field_of_study_code} #{field_of_study_name}".center 50, '_'
  end

  %i(faculty_name speciality_name specialization_name).each do |method|
    define_method(method) { object.send(method).center 50, '_' }
  end
end
