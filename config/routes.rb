Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "tweets#index"
  resources :tweets, only: [:index, :new, :create, :show]
  resources :users, only: [:show]
  resources :motions
end
