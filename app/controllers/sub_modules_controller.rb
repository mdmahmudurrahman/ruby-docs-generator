# frozen_string_literal: true
class SubModulesController < ApplicationController
  include Movable

  load_and_authorize_resource
  skip_authorize_resource only: %i(new create)
  load_and_authorize_resource :main_module, only: %i(new create)

  before_action :initialize_main_module, except: %i(new create)

  def show
  end

  def new
  end

  def edit
  end

  def create
    @sub_module = SubModule.create sub_module_params_with_main_module
    respond_with @sub_module, location: -> { @main_module }
  end

  def update
    @sub_module.update sub_module_params
    respond_with @sub_module, location: -> { @main_module }
  end

  def destroy
    @sub_module.destroy.destroyed?
    respond_with @sub_module, location: -> { @main_module }
  end

  private

  def initialize_main_module
    @main_module = @sub_module.main_module
  end

  def sub_module_params
    params.require(:sub_module).permit %i(name labs_time lectures_time)
  end

  def sub_module_params_with_main_module
    sub_module_params.merge main_module: @main_module
  end

  def load_movable_entity
    data = { id: params.dig(:sub_module_id) }
    @sub_module = SubModule.find_by data
    @moveable_entity = @sub_module
  end

  def perform_post_moving_action
    redirect_to @main_module
  end
end
