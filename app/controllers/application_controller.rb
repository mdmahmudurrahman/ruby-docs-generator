# frozen_string_literal: true
require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  responders :flash
  respond_to :html

  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
