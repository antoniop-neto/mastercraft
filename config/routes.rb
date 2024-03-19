Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "services/manage", to: "services#manage", as: :manage_services
  resources :bookings, only: [:edit, :update, :destroy]


  resources :services, only: [:index, :new, :create, :destroy] do
    resources :bookings, only: [:new, :create]
  end

  # Defines the root path route ("/")
  # root "posts#index"

  # As a user, I want to be able to view the list of available services a specific provider provides
  resources :users, only: [:show]
end
