# frozen_string_literal: true
class MainModuleDecorator < Draper::Decorator
  include NamePrefixProvider

  delegate_all

  decorates_association :sub_modules

  def name_prefix(value)
    I18n.t 'main_modules.decorator.prefix', value: value
  end
end
