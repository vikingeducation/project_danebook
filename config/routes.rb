Rails.application.routes.draw do

  get 'posts/index'
  get 'users/photos'
  get 'users/friends'
  root 'static_pages#home'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

end
