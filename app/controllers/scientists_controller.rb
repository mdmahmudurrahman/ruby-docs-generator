# frozen_string_literal: true
class ScientistsController < ApplicationController
  load_and_authorize_resource :document
  load_and_authorize_resource through: :document

  def new
    @scientist = Scientist.new
  end

  def create
    @scientist = Scientist.new scientist_params

    if @document.scientists << @scientist
      flash[:alert] = t '.alert'
      return redirect_to root_path
    end

    render :new
  end

  def destroy
    @scientist.destroy
    flash[:alert] = t '.alert'
    redirect_to root_path
  end

  private

  def scientist_params
    params.require(:scientist).permit %i(name position)
  end
end
