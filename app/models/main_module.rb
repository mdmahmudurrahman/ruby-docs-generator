# frozen_string_literal: true
class MainModule < ApplicationRecord
  ###=> associations

  belongs_to :document

  has_many :sub_modules, dependent: :destroy

  ###=> validation

  validates :name, :total_time, :document, presence: true
end
