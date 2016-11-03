# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users

  root 'documents#index'

  concern :movable do
    put 'move-lower'
    put 'move-higher'
  end

  resources :documents do
    get 'data', to: 'documents#data'
    get 'generate', to: 'documents#generate'

    resources :scientists, except: %i(index show)

    resources :main_modules, path: 'main-modules', except: %i(index), concerns: :movable
  end

  scope 'main-modules/:main_module_id', as: 'main_module' do
    resources :sub_modules, path: 'sub-modules', except: %i(index), concerns: :movable
  end

  scope 'sub-modules/:sub_module_id', as: 'sub_module' do
    resources :topics, except: %i(index), concerns: :movable
  end
end
