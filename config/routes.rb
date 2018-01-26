Rails.application.routes.draw do

  root 'sessions#new'

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  # users
  resources :users do
    resources :posts, except: [:index, :show] do
      resources :likes
      resources :comments, :defaults => { :commentable => 'Post' }
    end
    resources :photos, except: [:index, :show] do
      resources :likes
      resources :comments, :defaults => { :commentable => 'Photo' }
      resources :photo_assignments, only: [:create]
    end
    resources :comments, except: [:index, :show] do
      resources :likes
    end
    resource :timeline, only: [:show]
    resource :feed, only: [:show]
    resources :friends, only: [:index]
    resources :photos, only: [:index]
  end

  resources :friendings, :only => [:create, :destroy]

end
