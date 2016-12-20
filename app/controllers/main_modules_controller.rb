# frozen_string_literal: true
class MainModulesController < ApplicationController
  include Movable

  load_and_authorize_resource
  skip_authorize_resource only: %i(new create)
  load_and_authorize_resource :document, only: %i(new create)

  before_action :initialize_document, except: %i(new create)

  def show
  end

  def new
  end

  def edit
  end

  def create
    @main_module = MainModule.create main_module_params_with_document
    respond_with @main_module, location: -> { @document }
  end

  def update
    success = @main_module.update main_module_params
    respond_with @main_module, location: -> { @document }
  end

  def destroy
    success = @main_module.destroy.destroyed?
    respond_with @main_module, location: -> { @document }
  end

  private

  def initialize_document
    @document = @main_module.document
  end

  def main_module_params
    params.require(:main_module).permit %i(name total_time)
  end

  def main_module_params_with_document
    main_module_params.merge document: @document
  end

  def load_movable_entity
    data = { id: params.dig(:main_module_id) }
    @main_module = MainModule.find_by data
    @moveable_entity = @main_module
  end

  def perform_post_moving_action
    redirect_to @main_module.document
  end
end
