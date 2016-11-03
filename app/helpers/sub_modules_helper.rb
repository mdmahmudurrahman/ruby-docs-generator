# frozen_string_literal: true
module SubModulesHelper
  def topic_menu_options(sub_module, topic)
    { delete_link: sub_module_topic_path(sub_module, topic),
      update_link: edit_sub_module_topic_path(sub_module, topic) }
  end

  def topic_movers_options(sub_module, topic)
    { move_higher_url: sub_module_topic_move_higher_path(sub_module, topic),
      move_lower_url: sub_module_topic_move_lower_path(sub_module, topic) }
  end
end
