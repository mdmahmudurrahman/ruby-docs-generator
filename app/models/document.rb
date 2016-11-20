# frozen_string_literal: true
class Document < ApplicationRecord
  ###=> associations

  belongs_to :user

  has_many :scientists, dependent: :destroy

  has_many :labs, -> { order :position }, dependent: :destroy, inverse_of: :document
  has_many :practices, -> { order :position }, dependent: :destroy, inverse_of: :document

  has_many :main_modules, -> { order :position }, dependent: :destroy, inverse_of: :document

  ###=> validations

  validates :user, presence: true
end
