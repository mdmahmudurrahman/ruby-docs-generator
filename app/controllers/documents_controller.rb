# frozen_string_literal: true
class DocumentsController < ApplicationController
  load_and_authorize_resource
  decorates_assigned :document

  def index
    @documents = @documents.decorate
  end

  def new
    @document = Document.new
  end

  def show
    render :edit
  end

  def edit
  end

  def create
    @document = Document.create document_params_with_user
    return render :new unless @document.persisted?
    redirect_to root_path, alert: t('.alert')
  end

  def update
    success = @document.update document_params
    return render :edit unless success
    flash[:alert] = t '.alert'
    redirect_to root_path
  end

  def destroy
    success = @document.destroy.destroyed?
    flash[:alert] = t '.alert' if success
    redirect_to root_path
  end

  def document_data
    query = { id: params[:document_id] }
    @document = Document.find_by query
  end

  def generate
  end

  private

  def document_params
    params.require(:document).permit %i(
      faculty_name discipline_code discipline_name speciality_name field_of_study_code
      field_of_study_name specialization_name labs_count credits_count lectures_count
      semester_number type_of_control year_of_studying self_hours_count total_hours_count
    )
  end

  def document_params_with_user
    document_params.merge user: current_user
  end
end
