# frozen_string_literal: true

user = User.create email: 'user@example.com', password: '123456'

FactoryGirl.create :document, user: user
