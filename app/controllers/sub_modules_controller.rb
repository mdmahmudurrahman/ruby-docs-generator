# frozen_string_literal: true
class SubModulesController < ApplicationController
  load_and_authorize_resource :main_module
  load_and_authorize_resource through: :main_module

  def show
  end

  def new
    @sub_module = SubModule.new
  end

  def edit
  end

  def create
    @sub_module = SubModule.create sub_module_params_with_main_module
    return render :new unless @sub_module.persisted?
    redirect_to [@main_module.document, @main_module], alert: t('.alert')
  end

  def update
    success = @sub_module.update sub_module_params
    return render :edit unless success
    redirect_to @main_module, alert: t('.alert')
  end

  def destroy
    success = @sub_module.destroy
    flash[:alert] = t '.alert' if success
    redirect_to @main_module
  end

  private

  def sub_module_params
    params.require(:sub_module).permit %i(
      name
      lectures_count
      labs_count
    )
  end

  def sub_module_params_with_main_module
    sub_module_params.merge main_module: @main_module
  end
end
