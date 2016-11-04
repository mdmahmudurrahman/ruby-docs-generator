# frozen_string_literal: true
class TopicDecorator < Draper::Decorator
  include NamePrefixProvider

  delegate_all

  def name_prefix(value)
    I18n.t 'topics.decorator.prefix', value: value
  end
end
