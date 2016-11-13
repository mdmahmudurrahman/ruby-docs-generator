# frozen_string_literal: true
class ScientistDecorator < Draper::Decorator
  delegate_all

  def positions
    %i(examiner practician).select { |field| scientist.send field }
      .map { |field| I18n.t "scientists.list.#{field}" }.join ', '
  end
end
