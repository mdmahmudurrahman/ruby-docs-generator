# frozen_string_literal: true
module MainModulesHelper
  def sub_module_menu_options(main_module, sub_module)
    { delete_link: main_module_sub_module_path(main_module, sub_module),
      update_link: edit_main_module_sub_module_path(main_module, sub_module) }
  end

  def sub_module_movers_options(main_module, sub_module)
    { move_higher_url: main_module_sub_module_move_higher_path(main_module, sub_module),
      move_lower_url: main_module_sub_module_move_lower_path(main_module, sub_module) }
  end
end
