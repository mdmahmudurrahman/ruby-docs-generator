# frozen_string_literal: true
module DocumentsHelper
  def number_input_options
    { input_html: { min: 0 } }
  end

  def document_menu_options(document)
    { delete_link: document_path(document),
      update_link: edit_document_path(document) }
  end

  def main_module_menu_options(document, main_module)
    { delete_link: document_main_module_path(document, main_module),
      update_link: edit_document_main_module_path(document, main_module) }
  end

  def main_module_movers_options(document, main_module)
    { move_higher_url: document_main_module_move_higher_path(document, main_module),
      move_lower_url: document_main_module_move_lower_path(document, main_module) }
  end
end
