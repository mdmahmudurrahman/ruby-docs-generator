# frozen_string_literal: true
class Topic < ApplicationRecord
  ###=> associations

  belongs_to :sub_module

  ###=> validations

  validates :name, :labs_time, :lectures_time, :sub_module, presence: true
end
