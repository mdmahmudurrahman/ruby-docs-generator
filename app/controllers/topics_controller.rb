# frozen_string_literal: true
class TopicsController < ApplicationController
  before_action only: %i(edit update) do
    @topic = Topic.find_by id: params[:id]
    @sub_module = SubModule.find_by id: params[:sub_module_id]
  end

  before_action only: %i(new create) do
    @sub_module = SubModule.find_by id: params[:sub_module_id]
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new topic_params

    if @sub_module.topics << @topic
      flash[:success] = 'Тема успешно добавлена!'
      return redirect_to new_sub_module_topic_path(@sub_module)
    end

    render :new
  end

  def edit
  end

  def update
    if @topic.update_attributes topic_params
      flash[:success] = 'Тема успешно изменена!'
      return redirect_to edit_sub_module_topic_path(@sub_module, @topic)
    end

    render :edit
  end

  def destroy
    Topic.find_by(id: params[:id]).destroy

    redirect_to root_path
  end

  private

  def topic_params
    params.require(:topic).permit %i(
      name
      lecture_count
      labs_count
    )
  end
end
