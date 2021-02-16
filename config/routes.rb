Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "tweets#index"
  resources :tweets, only: [:index, :new, :create, :show] do
    resources :comments, only: [:create, :update, :edit, :destroy]
  end
  resources :users, only: [:show]
  resources :motions
end
