Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :timeline,   only: [:show]
    resource :newsfeed,   only: [:show]
    resource :friendings, only: [:create, :destroy]
    resources :friends,   only: [:index]
    resources :photos,    only: [:index]
  end

  resources :photos, except: [:index] do
    resources :comments, only: [:create], :defaults => { :commentable => 'Photo' }
    post "set_as_profile"
    post "set_as_cover"
  end

  resources :posts, only: [:create, :update, :destroy] do
    resources :comments, only: [:create], :defaults => { :commentable => 'Post' }
  end

  resources :comments, only: [:update, :destroy]

  resource :profile, only: [:show, :edit, :update]
  resource :session, :only => [:create, :destroy]
  resource :like, :only => [:create, :destroy]

# ------------------------ Aliases ----------------------------

  get "login" => "users#new"
  delete "logout" => "sessions#destroy"
  get "about" => "users#show"

# ------------------------ Page not found -----------------------

  get "*path", to: redirect { |p, req| req.flash[:error] = "Oh snaps you dont want to go there "; '/' }

end
