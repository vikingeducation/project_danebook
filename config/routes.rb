Rails.application.routes.draw do
  root 'sessions#new'

  resource :session, :only => [:new, :create, :destroy]
  get "/login" => "sessions#new"
  get "/logout" => "sessions#destroy"
  delete "/logout" => "sessions#destroy"
  get "/login" => "users#new"

  resources :users, only: [:index, :show, :create, :update] do
    resource :profile, only: [:show]
    resources :photos, only: [:new, :index, :edit, :show]
    resources :friendings, only: [:index]
    get 'newsfeed' => "users#newsfeed"
  end

  resource :profile, only: [:edit, :update]

  resources :photos, only: [:create, :update, :destroy] do
    resources :likes, only: [:create], :defaults => { :likeable => 'Photo'}
    resources :comments, only: [:new, :create]
  end

  resources :posts, only: [:create, :update, :destroy] do
    resources :likes, only: [:create], :defaults => { :likeable => 'Post'}
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:create, :destroy] do
    resources :likes, only: [:create], :defaults => { :likeable => 'Comment'}
  end

  resources :likes, only: [:destroy]

  resources :friendings, :only => [:create, :destroy]
end
