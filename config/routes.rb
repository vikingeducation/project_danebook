Rails.application.routes.draw do
  root 'users#new'
  
  resources :users do
    resources :posts 
  end

  # post "profile_photo" => 'photos#profile_photo'
  # get "cover_photo" => 'photos#cover_photo'

  get "photos/:id/cover_photo" => 'photos#cover_photo', as: "cover_photo"
  get "photos/:id/profile_photo" => 'photos#profile_photo', as: "profile_photo"

  resource :sessions, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resources :likes
  resources :comments
  resources :friendings
  resources :photos
end
