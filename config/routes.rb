Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :roles
      resources :users
      resources :assignments
      resources :participants, only: [:destroy] do
        collection do
          get ':model/:id', to: 'participants#index'
          post ':model/:id', to: 'participants#create'
          patch 'update_handle/:id', to: 'participants#update_handle'
          patch 'update_authorization/:id', to: 'participants#update_authorization'
          get 'inherit/:id', to: 'participants#inherit'
          get 'bequeath/:id', to: 'participants#bequeath'
        end
      end
    end
  end
end
