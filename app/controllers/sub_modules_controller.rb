# frozen_string_literal: true
class SubModulesController < ApplicationController
  before_action only: %i(edit update) do
    @main_module = MainModule.find_by(id: params[:main_module_id])
    @sub_module = SubModule.find_by(id: params[:id])
  end

  before_action only: %i(new create) do
    @main_module = MainModule.find_by(id: params[:main_module_id])
  end

  def new
    @sub_module = SubModule.new
  end

  def create
    @sub_module = SubModule.new sub_module_params

    if @main_module.sub_modules << @sub_module
      flash[:success] = 'Подмодуль успешно добавлен!'
      return redirect_to new_main_module_sub_module_path(@main_module)
    end

    render 'new.html.erb'
  end

  def edit
  end

  def update
    if @sub_module.update_attributes(sub_module_params)
      flash[:success] = 'Подмодуль успешно изменен!'
      return redirect_to edit_main_module_sub_module_path(@main_module, @sub_module)
    end

    render 'edit.html.erb'
  end

  def destroy
    SubModule.find_by(id: params[:id]).destroy

    redirect_to root_path
  end

  private

  def sub_module_params
    params.require(:sub_module).permit %i(
      name
      lecture_count
      labs_count
    )
  end
end
