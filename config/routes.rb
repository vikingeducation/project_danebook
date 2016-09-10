Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get 'timeline/:id', to: 'pages#timeline', as: 'timeline'
  get 'search',       to: 'pages#search',   as: 'search'
  get '/friends/:id', to: 'users#index',    as: 'friends'
  post 'new/linkphoto',   to: 'photos#new_link_photo', as: 'new_link_photo'
  resources :users, only: [:show, :edit, :update]
  resources :posts, except: [:new, :index]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :friendings, only: [:create, :destroy]
  resources :photos
  resource  :avatars, only: [:create]
  resource  :cover_images, only: [:create]
end
