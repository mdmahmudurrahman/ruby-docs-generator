# frozen_string_literal: true
class MainModulesController < ApplicationController
  load_and_authorize_resource :document
  load_and_authorize_resource through: :document

  def show
  end

  def new
    @main_module = MainModule.new
  end

  def edit
  end

  def create
    @main_module = MainModule.create main_module_params_with_document
    return render :new unless @main_module.persisted?
    redirect_to @document, alert: t('.alert')
  end

  def update
    success = @main_module.update main_module_params
    return render :edit unless success
    flash[:alert] = t '.alert'
    redirect_to @document
  end

  def destroy
    success = @main_module.destroy.destroyed?
    flash[:alert] = t '.alert' if success
    redirect_to @document
  end

  private

  def main_module_params
    params.require(:main_module).permit %i(name total_time)
  end

  def main_module_params_with_document
    main_module_params.merge document: @document
  end
end