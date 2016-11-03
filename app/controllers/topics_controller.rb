# frozen_string_literal: true
class TopicsController < ApplicationController
  load_and_authorize_resource :sub_module
  load_and_authorize_resource through: :sub_module

  def show
  end

  def edit
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.create topic_params_with_sub_module
    return render :new unless @topic.persisted?
    flash[:alert] = I18n.t 'topics.create.alert'
    main_module = @sub_module.main_module
    redirect_to [main_module, @sub_module]
  end

  def update
    return render :edit unless @topic.update topic_params
    flash[:alert] = I18n.t 'topics.update.alert'
    main_module = @sub_module.main_module
    redirect_to [main_module, @sub_module]
  end

  def destroy
    flash[:alert] = t '.alert' if @topic.destroy.destroyed?
    redirect_to [@sub_module.main_module, @sub_module]
  end

  private

  def topic_params
    params.require(:topic).permit %i(
      name labs_time lectures_time
    )
  end

  def topic_params_with_sub_module
    topic_params.merge sub_module: @sub_module
  end
end