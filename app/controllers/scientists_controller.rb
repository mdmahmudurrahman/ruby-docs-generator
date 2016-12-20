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
    @scientist.update document: @document

    # if entity isn't saved successfully
    # then render form with errors
    # if entity is saved successfully
    # then redirect to document page and
    # show alert about successfully creation
    respond_with @scientist, location: -> { @document }
  end

  def update
    @scientist.update scientist_params
    respond_with @scientist, location: -> { @document }
  end

  def destroy
    @scientist.destroy.destroyed?
    respond_with @scientist, location: -> { @document }
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
