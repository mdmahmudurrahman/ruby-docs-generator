# frozen_string_literal: true
module SubModulesHelper
  def topic_menu_options(sub_module, topic)
    { delete_link: sub_module_topic_path(sub_module, topic),
      update_link: edit_sub_module_topic_path(sub_module, topic) }
  end
end
