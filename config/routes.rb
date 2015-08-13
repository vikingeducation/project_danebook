Rails.application.routes.draw do

  get 'about', to: 'static_pages_controller#about', as: 'about'

  get 'about_edit', to: 'static_pages_controller#about_edit', as: 'about_edit'

  get 'friends', to: 'static_pages_controller#friends', as: 'friends'

  get 'photos', to: 'static_pages_controller#photos', as: 'photos'

  root "users#new"

  resources :users do
    resources :posts
    resources :likes
    resources :comments
    resources :photos
  end

  resources :timelines, :only => [:show]
  resources :friends, :only => [:show]
  resources :profiles
  resource :session, :only => [:new, :create, :destroy]
  resources :friendships, :only => [:create, :destroy]

  get "login" => "sessions#new"

  get "logout" => "sessions#destroy"


end
