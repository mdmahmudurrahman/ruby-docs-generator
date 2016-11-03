# frozen_string_literal: true
class MainModule < ApplicationRecord
  ###=> libs

  acts_as_list scope: :document

  ###=> associations

  belongs_to :document

  has_many :sub_modules, -> { order :position }, dependent: :destroy

  ###=> validation

  validates :name, :total_time, :document, presence: true
end
