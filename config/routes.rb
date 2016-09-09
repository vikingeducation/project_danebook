Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'timeline/:id', to: 'pages#timeline', as: 'timeline'
  get 'search',       to: 'pages#search',   as: 'search'
  get '/friends/:id', to: 'users#index',    as: 'friends'
  resources :users, only: [:show, :edit, :update]
  resources :posts, except: [:new, :index]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :friendings, only: [:create, :destroy]
end
