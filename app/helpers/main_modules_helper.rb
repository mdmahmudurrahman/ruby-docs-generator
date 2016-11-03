# frozen_string_literal: true
module MainModulesHelper
  def sub_module_menu_options(main_module, sub_module)
    { delete_link: main_module_sub_module_path(main_module, sub_module),
      update_link: edit_main_module_sub_module_path(main_module, sub_module) }
  end
end
