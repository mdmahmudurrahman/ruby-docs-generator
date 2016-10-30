# frozen_string_literal: true
class Topic < ApplicationRecord
  ###=> associations

  belongs_to :sub_module

  ###=> validations

  validates :name, :lecture_count, :labs_count, :sub_module, presence: true
end
