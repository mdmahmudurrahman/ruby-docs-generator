# frozen_string_literal: true
module NamePrefixProvider
  extend ActiveSupport::Concern

  included do
    def name_prefix(_value)
      raise NotImplementedException
    end

    def name_with_prefix(value)
      name_prefix(value) + main_module.name
    end
  end
end
