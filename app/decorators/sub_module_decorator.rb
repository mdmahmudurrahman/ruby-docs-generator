# frozen_string_literal: true
class SubModuleDecorator < Draper::Decorator
  include NamePrefixProvider

  delegate_all

  decorates_association :topics

  def name_prefix(value)
    I18n.t 'sub_modules.decorator.prefix', value: value
  end

  def table_label(value)
    I18n.t 'sub_modules.decorator.table_label', value: value
  end
end
