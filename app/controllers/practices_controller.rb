# frozen_string_literal: true
class PracticesController < ApplicationController
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
    saved = @practice.update document: @document
    return render :new unless saved

    redirect_to @document, alert: t('.alert')
  end

  def update
    success = @practice.update practice_params
    return render :edit unless success
    flash[:alert] = t '.alert'
    redirect_to @document
  end

  def destroy
    success = @practice.destroy.destroyed?
    flash[:alert] = t '.alert' if success
    redirect_to @document
  end

  private

  def initialize_document
    @document = @practice.document
  end

  def practice_params
    params.require(:practice).permit %i(
      name time_count
    )
  end

  def load_movable_entity
    data = { id: params.dig(:practice_id) }
    @practice = Practice.find_by data
    @moveable_entity = @practice
  end

  def perform_post_moving_action
    redirect_to @practice.document
  end
end
