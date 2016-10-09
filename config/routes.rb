Rails.application.routes.draw do

  root "users#index"

  resources :users do
    resource :profile, only: [:show]
    resources :posts, only: [:create, :destroy]
    get "timeline" => "users#show"
    get "newsfeed" => "users#newsfeed"
    resources :comments, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy, :index, :new, :show]
  end

  resource :profile, only: [:edit, :update] do
    get "profile_photo" => "profiles#photo"
    get "cover_photo" => "profiles#cover"
  end

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resource :static_pages, only: [:index, :show, :new]

  resources :friendings, :only => [:create, :destroy, :show]

  resources :posts, only: [] do
    get "cfield" => "posts#cfield"
    resources :likes, only: [:create, :destroy], :defaults => { :likeable => 'Post' }
  end

  resources :photos, only: [] do
    resources :likes, only: [:create, :destroy], :defaults => { :likeable => 'Photo' }
  end

  get "search" => "profiles#search"

end
