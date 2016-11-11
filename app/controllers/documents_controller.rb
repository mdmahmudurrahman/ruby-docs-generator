# frozen_string_literal: true
class DocumentsController < ApplicationController
  load_and_authorize_resource
  decorates_assigned :document

  before_action only: %i(data generate) do
    query = { id: params[:document_id] }
    dependencies = { main_modules: [sub_modules: [:topics]] }
    @document = Document.includes(dependencies).find_by query
  end

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

  def data
  end

  def generate
  end

  private

  def document_params
    params.require(:document).permit %i(
      field_of_study_name specialization_name labs_time credits_count
      lectures_time faculty_name discipline_code discipline_name speciality_name
      semester_number field_of_study_code type_of_control year_of_studying
      self_hours_count total_hours_count cathedra_name groups_codes
    )
  end

  def document_params_with_user
    document_params.merge user: current_user
  end
end
