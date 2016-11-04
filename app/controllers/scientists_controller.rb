# frozen_string_literal: true
class ScientistsController < ApplicationController
  load_and_authorize_resource :document
  load_and_authorize_resource through: :document

  def new
    @scientist = Scientist.new
  end

  def edit
  end

  def create
    @scientist = Scientist.create scientist_params_with_document
    return render :new unless @scientist.persisted?
    redirect_to @document, alert: t('.alert')
  end

  def update
    success = @scientist.update scientist_params
    return render :edit unless success
    flash[:alert] = t '.alert'
    redirect_to @document
  end

  def destroy
    success = @scientist.destroy.destroyed?
    flash[:alert] = t '.alert' if success
    redirect_to @document
  end

  private

  def scientist_params
    params.require(:scientist).permit %i(name position)
  end

  def scientist_params_with_document
    scientist_params.merge document: @document
  end
end
