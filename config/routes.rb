# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users

  root 'documents#index'

  resources :documents do
    get 'generate', to: 'documents#generate'
    get 'document-data', to: 'documents#document_data'

    resources :scientists, except: %i(index show)

    resources :main_modules, path: 'main-modules', except: %i(index)
  end

  scope 'main-modules/:main_module_id', as: 'main_module' do
    resources :sub_modules, path: 'sub-modules', except: %i(index)
  end

  scope 'sub-modules/:sub_module_id', as: 'sub_module' do
    resources :topics, except: %i(index)
  end
end
