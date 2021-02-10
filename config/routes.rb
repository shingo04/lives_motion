Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "tweets#index"
  resources :tweets, only: [:index, :new, :create]
  resources :users, only: [:show]
end
