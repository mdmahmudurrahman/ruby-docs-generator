# frozen_string_literal: true
class Practice < ApplicationRecord
  acts_as_list scope: :document

  belongs_to :document

  validates :name, :time_count, presence: true
end
