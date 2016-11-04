# frozen_string_literal: true
class Topic < ApplicationRecord
  ###=> libs

  acts_as_list scope: :sub_module

  ###=> associations

  belongs_to :sub_module

  ###=> validations

  validates :name, :sub_module, presence: true
end
