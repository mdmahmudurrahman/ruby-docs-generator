# frozen_string_literal: true
module DocumentsHelper
  def number_input_options
    { input_html: { min: 0 } }
  end

  def context_menu_options(document)
    { delete_link: document_path(document),
      update_link: edit_document_path(document) }
  end
end
