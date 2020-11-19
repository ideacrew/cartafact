# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :documents, only: [:index, :show, :create, :update, :destroy] do
        member do
          get :download
          post :update_meta_data
        end
      end
    end
  end
end
