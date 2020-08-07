# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :documents, only: [:index, :show, :create] do
        member do
          get :download
        end
      end
    end
  end
end
