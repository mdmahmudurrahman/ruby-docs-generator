# frozen_string_literal: true
module ScientistsHelper
  def scientist_menu_options(document, scientist)
    { delete_link: document_scientist_path(document, scientist),
      update_link: edit_document_scientist_path(document, scientist) }
  end
end
