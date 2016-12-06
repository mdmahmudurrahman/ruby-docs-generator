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
    @practice.update document: @document
    respond_with @practice, location: -> { @document }
  end

  def update
    @practice.update practice_params
    respond_with @practice, location: -> { @document }
  end

  def destroy
    @practice.destroy.destroyed?
    respond_with @practice, location: -> { @document }
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
