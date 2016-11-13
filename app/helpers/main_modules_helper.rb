# frozen_string_literal: true
module MainModulesHelper
  def sub_module_menu_options(sub_module)
    { delete_link: sub_module_path(sub_module),
      update_link: edit_sub_module_path(sub_module) }
  end

  def sub_module_movers_options(sub_module)
    { move_higher_url: sub_module_move_higher_path(sub_module),
      move_lower_url: sub_module_move_lower_path(sub_module) }
  end
end
