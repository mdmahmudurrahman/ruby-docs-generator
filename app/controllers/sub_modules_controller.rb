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
    flash[:alert] = I18n.t 'sub_modules.create.alert'
    redirect_to [@main_module.document, @main_module]
  end

  def update
    return render :edit unless @sub_module.update sub_module_params
    flash[:alert] = I18n.t 'sub_modules.update.alert'
    redirect_to [@main_module.document, @main_module]
  end

  def destroy
    flash[:alert] = t '.alert' if @sub_module.destroy.destroyed?
    redirect_to [@main_module.document, @main_module]
  end

  private

  def sub_module_params
    params.require(:sub_module).permit %i(
      name labs_time lectures_time
    )
  end

  def sub_module_params_with_main_module
    sub_module_params.merge main_module: @main_module
  end
end
