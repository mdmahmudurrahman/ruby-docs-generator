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
    @lab.update document: @document
    respond_with @lab, location: -> { @document }
  end

  def update
    @lab.update lab_params
    respond_with @lab, location: -> { @document }
  end

  def destroy
    @lab.destroy.destroyed?
    respond_with @lab, location: -> { @document }
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
