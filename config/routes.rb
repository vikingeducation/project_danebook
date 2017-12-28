Rails.application.routes.draw do
  root 'users#new'
  
  resources :users do
    resources :posts 
  end
  resource :sessions, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resources :likes
  resources :comments
  resources :friendings
  resources :photos
end
