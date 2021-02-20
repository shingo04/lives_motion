Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'users', to: "users/registrations#new"
  end
  root to: "tweets#index"
  resources :tweets, only: [:index, :new, :create, :show, :destroy] do
    resources :comments, only: [:create, :update, :edit, :destroy]
  end
  resources :users, only: [:show]
  resources :motions
end
