Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  resources :categories
  resources :products do
    resource :buy_now, only: [:show, :create], controller: :buy_now do
      get "success", on: :collection
    end

    resource :favorite, only: [:create, :destroy]
  end

  resources :carts, only: [:create]

  get 'favorites', to: 'favorites#index', as: :favorites
  
  resource :admin, only: [:show], controller: :admin
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "products#index"
end
