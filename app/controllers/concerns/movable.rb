# frozen_string_literal: true
module Movable
  extend ActiveSupport::Concern

  included do
    before_action :load_movable_entity, only: %i(
      move_higher move_lower
    )

    def move_higher
      @moveable_entity.move_higher
      perform_post_moving_action
    end

    def move_lower
      @moveable_entity.move_lower
      perform_post_moving_action
    end

    private

    def load_movable_entity
      raise NotImplementedException
    end

    def perform_post_moving_action
      raise NotImplementedException
    end
  end
end
