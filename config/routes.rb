Rails.application.routes.draw do
  root 'users#new'
  
  resources :users do
    resources :posts 
  end

  get "users/:user_id/cover_photo/:id" => 'users#cover_photo', as: "user_cover_photo"
  get "users/:user_id/profile_photo/:id" => 'users#profile_photo', as: "user_profile_photo"

  # get "search/:query" => 'users#search', as: "users_search"
  get "newsfeed" => 'posts#newsfeed', as: "newsfeed"

  resource :sessions, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resources :likes
  resources :comments
  resources :friendings
  resources :photos
end
