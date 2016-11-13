# frozen_string_literal: true
class AddLabsAndLecturesTimeToTopics < ActiveRecord::Migration[5.0]
  def change
    add_column :topics, :labs_time, :integer
    add_column :topics, :lectures_time, :integer
  end
end
