# frozen_string_literal: true
class ScientistsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: %i(new create)
  load_and_authorize_resource :document, only: %i(new create)

  before_action :initialize_document, except: %i(new create)

  def new
  end

  def edit
  end

  def create
    # save new scientist to database
    saved = @scientist.update document: @document

    # if entity isn't saved successfully
    # then render form with errors
    return render :new unless saved

    # if entity is saved successfully
    # then redirect to document page and
    # show alert about successfully creation
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

  def initialize_document
    @document = @scientist.document
  end

  def scientist_params
    params.require(:scientist).permit %i(
      name position examiner practician
    )
  end
end
