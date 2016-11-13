# frozen_string_literal: true
module SubModulesHelper
  def topic_menu_options(topic)
    { delete_link: topic_path(topic),
      update_link: edit_topic_path(topic) }
  end

  def topic_movers_options(topic)
    { move_higher_url: topic_move_higher_path(topic),
      move_lower_url: topic_move_lower_path(topic) }
  end
end
