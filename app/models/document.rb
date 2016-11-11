# frozen_string_literal: true
class Document < ApplicationRecord
  ###=> associations

  belongs_to :user

  has_many :scientists, dependent: :destroy

  has_many :main_modules, -> { order :position }, dependent: :destroy, inverse_of: :document

  ###=> validations

  validates :user, presence: true
end
