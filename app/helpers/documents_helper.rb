# frozen_string_literal: true
module DocumentsHelper
  def number_input_options
    { input_html: { min: 0 } }
  end

  def document_menu_options(document)
    { delete_link: document_path(document),
      update_link: edit_document_path(document) }
  end

  def main_module_menu_options(main_module)
    { delete_link: main_module_path(main_module),
      update_link: edit_main_module_path(main_module) }
  end

  def main_module_movers_options(main_module)
    { move_higher_url: main_module_move_higher_path(main_module),
      move_lower_url: main_module_move_lower_path(main_module) }
  end

  def scientist_menu_options(scientist)
    { delete_link: scientist_path(scientist),
      update_link: edit_scientist_path(scientist) }
  end
end
