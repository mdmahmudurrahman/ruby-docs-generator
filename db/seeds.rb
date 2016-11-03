# frozen_string_literal: true

include FactoryGirl::Syntax::Methods

user = User.create email: 'user@example.com', password: '123456'

create :document, user: user do |document|
  create_list :main_module, 2, document: document do |main_module|
    create_list :sub_module, 2, main_module: main_module do |sub_module|
      create_list :topic, 4, sub_module: sub_module
    end
  end
end
