# frozen_string_literal: true
class DocumentsController < ApplicationController
  def new
    @document = Document.first || Document.new
  end

  def create
    @document = Document.create document_params
    redirect_to document_generate_path @document
  end

  def update
    @document = Document.first
    @document.update document_params
    redirect_to document_generate_path @document
  end

  def generate
  end

  private

  def document_params
    params.require(:document).permit %i(
      faculty_name
      discipline_code
      discipline_name
      speciality_name
      field_of_study_code
      field_of_study_name
      specialization_name
    )
  end
end
