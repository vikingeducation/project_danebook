Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
    resource :timeline, only: [:show]
    resources :posts, only: [:new, :create, :destroy]

  end

  resources :posts, only: [:new, :create, :destroy] do
      resource :like, only: [:create, :destroy], :defaults => { :likeable => 'Post' }
      resource :comment, :defaults => { :commentable => 'Post' }
  end

  resources :comments do
    resource :like, only: [:create, :destroy], :defaults => { :likeable => 'Comment' }
    # resource :comment, :defaults => { :commentable => 'Comment' }
  end

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

end
