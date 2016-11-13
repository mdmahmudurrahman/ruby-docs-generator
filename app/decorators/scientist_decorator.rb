class ScientistDecorator < Draper::Decorator
  delegate_all

  def scientists_positions
    if examiner && labs_and_practicer
      "(#{I18n.t 'scientists.list.examiner'}, #{I18n.t 'scientists.list.labs_and_practicer'})"
    elsif examiner
      "(#{I18n.t 'scientists.list.examiner'})"
    else
      "(#{I18n.t 'scientists.list.labs_and_practicer'})"
    end
  end
end
