Rails.application.routes.draw do

  resources :users, only: [:new, :create, :update, :show]
  resources :profiles, only: [:show, :edit, :update]
  resource :session, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy]
  root 'users#new', as: :signup
  
end
