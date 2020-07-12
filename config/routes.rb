Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :documents, only: [:index, :show, :create] do
        collection do
          post :upload
        end

        member do
          get :find
          get :download
        end
      end
    end
  end
end
