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
    flash[:alert] = t 'scientists.create.alert'
    redirect_to @document
  end

  def update
    return render :edit unless @scientist.update scientist_params
    flash[:alert] = I18n.t 'scientists.update.alert'
    redirect_to @document
  end

  def destroy
    flash[:alert] = I18n.t 'scientists.destroy.alert' if @scientist.destroy.destroyed?
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
