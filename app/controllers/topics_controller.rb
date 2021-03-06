# frozen_string_literal: true
class TopicsController < ApplicationController
  include Movable

  load_and_authorize_resource
  skip_authorize_resource only: %i(new create)
  load_and_authorize_resource :sub_module, only: %i(new create)

  before_action :initialize_sub_module, except: %i(new create)

  def new
    @topic = Topic.new calculate_time: true
  end

  def edit
  end

  def create
    @topic = Topic.create topic_params_with_sub_module
    @sub_module.calculate_topics_time

    respond_with @topic, location: -> { @sub_module }
  end

  def update
    @topic.update topic_params
    @sub_module.calculate_topics_time

    respond_with @topic, location: -> { @sub_module }
  end

  def destroy
    @topic.destroy
    @sub_module.calculate_topics_time

    respond_with @topic, location: -> { @sub_module }
  end

  private

  def initialize_sub_module
    @sub_module = @topic.sub_module
  end

  def topic_params
    params.require(:topic).permit %i(name labs_time lectures_time calculate_time)
  end

  def topic_params_with_sub_module
    topic_params.merge sub_module: @sub_module
  end

  def load_movable_entity
    data = { id: params.dig(:topic_id) }
    @topic = Topic.find_by data
    @moveable_entity = @topic
  end

  def perform_post_moving_action
    redirect_to @sub_module
  end
end
