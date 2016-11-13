# frozen_string_literal: true
class Topic < ApplicationRecord
  ###=> libs

  acts_as_list scope: :sub_module

  ###=> associations

  belongs_to :sub_module

  ###=> validations

  validates :name, :sub_module, presence: true

  validates :labs_time, :lectures_time, presence: true, if: '!calculate_time'

  ###=> scopes

  scope :with_set_time, -> { where calculate_time: false }
  scope :with_calculated_time, -> { where calculate_time: true }
end
