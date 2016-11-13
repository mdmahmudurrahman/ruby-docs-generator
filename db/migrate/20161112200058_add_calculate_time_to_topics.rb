# frozen_string_literal: true
class AddCalculateTimeToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :calculate_time, :boolean
  end
end
