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

    resources :labs, only: %i(new create)
    resources :practices, only: %i(new create)
    resources :scientists, only: %i(new create)

    resources :main_modules, path: 'main-modules', only: %i(new create)
  end

  resources :scientists, except: %i(index show new create)
  resources :labs, expect: %i(index show new create), concerns: :movable
  resources :practices, expect: %i(index show new create), concerns: :movable

  resources :main_modules, path: 'main-modules', except: %i(new create), concerns: :movable

  scope 'main-modules/:main_module_id', as: 'main_module' do
    resources :sub_modules, path: 'sub-modules', only: %i(new create)
  end

  resources :sub_modules, path: 'sub-modules', except: %i(new create), concerns: :movable

  scope 'sub-modules/:sub_module_id', as: 'sub_module' do
    resources :topics, only: %i(new create)
  end

  resources :topics, except: %i(new show create), concerns: :movable
end
