# frozen_string_literal: true
class Scientist < ApplicationRecord
  ###=> associations

  belongs_to :document

  ###=> validations

  validates :name, :position, :document, presence: true
end
