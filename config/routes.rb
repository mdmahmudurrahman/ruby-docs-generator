# frozen_string_literal: true
Rails.application.routes.draw do
  root 'documents#new'

  resources :documents, only: %i(new create update) do
    get 'generate', to: 'documents#generate'
  end
end
