# frozen_string_literal: true
class MainModulesController < ApplicationController
  load_and_authorize_resource :document
  load_and_authorize_resource through: :document

  def new
    @main_module = MainModule.new
  end

  def create
    @main_module = MainModule.new main_module_params

    if @document.main_modules << @main_module
      flash[:alert] = t '.alert'
      return redirect_to root_path
    end

    render :new
  end

  def edit
  end

  def update
    if @main_module.update_attributes main_module_params
      return redirect_to root_path, alert: t('.alert')
    end

    render :edit
  end

  def destroy
    @main_module.destroy
    flash[:alert] = t '.alert'
    redirect_to root_path
  end

  private

  def main_module_params
    params.require(:main_module).permit %i(name total_time)
  end
end
