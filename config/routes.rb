Rails.application.routes.draw do
  devise_for :users
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :cars, only: %i[index show new create] do
    resources :bookings, only: %i[new create]
  end

  resources :bookings, only: %i[index]

  # Defines the root path route ("/")
  root to: "cars#index"
end
