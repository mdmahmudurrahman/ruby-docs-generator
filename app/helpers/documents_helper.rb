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

  def lab_menu_options(lab)
    { delete_link: lab_path(lab),
      update_link: edit_lab_path(lab) }
  end

  def lab_movers_options(lab)
    { move_higher_url: lab_move_higher_path(lab),
      move_lower_url: lab_move_lower_path(lab) }
  end

  def practice_menu_options(practice)
    { delete_link: practice_path(practice),
      update_link: edit_practice_path(practice) }
  end

  def practice_movers_options(practice)
    { move_higher_url: practice_move_higher_path(practice),
      move_lower_url: practice_move_lower_path(practice) }
  end
end
