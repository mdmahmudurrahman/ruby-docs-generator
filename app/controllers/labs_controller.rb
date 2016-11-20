# frozen_string_literal: true
class LabsController < ApplicationController
  include Movable

  load_and_authorize_resource
  skip_authorize_resource only: %i(new create)
  load_and_authorize_resource :document, only: %i(new create)

  before_action :initialize_document, except: %i(new create)

  def new
  end

  def edit
  end

  def create
    saved = @lab.update document: @document
    return render :new unless saved

    redirect_to @document, alert: t('.alert')
  end

  def update
    success = @lab.update lab_params
    return render :edit unless success
    flash[:alert] = t '.alert'
    redirect_to @document
  end

  def destroy
    success = @lab.destroy.destroyed?
    flash[:alert] = t '.alert' if success
    redirect_to @document
  end

  private

  def initialize_document
    @document = @lab.document
  end

  def lab_params
    params.require(:lab).permit %i(
      name time_count
    )
  end

  def load_movable_entity
    data = { id: params.dig(:lab_id) }
    @lab = Lab.find_by data
    @moveable_entity = @lab
  end

  def perform_post_moving_action
    redirect_to @lab.document
  end
end
