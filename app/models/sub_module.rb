# frozen_string_literal: true
class SubModule < ApplicationRecord
  ###=> libs

  acts_as_list scope: :main_module

  ###=> associations

  belongs_to :main_module

  has_many :topics, -> { order :position }, dependent: :destroy

  ###=> validations

  validates :name, :labs_time, :lectures_time, :main_module, presence: true

  ###=> delegates

  delegate :with_set_time, :with_calculated_time, to: :topics, prefix: true

  ###=> methods

  def calculate_topics_time
    unless topics_with_calculated_time.empty?
      labs_and_lectures_time = {
        labs_time: labs_time_per_topic,
        lectures_time: lectures_time_per_topic
      }

      topics_with_calculated_time.each do |topic|
        topic.update labs_and_lectures_time
      end
    end
  end

  %i(labs_time lectures_time).each do |field|
    define_method "total_#{field}_for_topics_with_set_time" do
      topics_with_set_time.map { |topic| topic.send field }.inject(:+) || 0
    end

    define_method "total_#{field}_for_topics_with_calculated_time" do
      send(field) * 1.0 - send("total_#{field}_for_topics_with_set_time")
    end

    define_method "#{field}_per_topic" do
      send("total_#{field}_for_topics_with_calculated_time") /
        topics_with_calculated_time.size
    end
  end
end
