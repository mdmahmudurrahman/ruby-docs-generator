# frozen_string_literal: true
class SubModule < ApplicationRecord
  ###=> associations

  belongs_to :main_module

  has_many :topics, dependent: :destroy

  ###=> validations

  validates :name, :lectures_count, :labs_count, :main_module, presence: true
end
