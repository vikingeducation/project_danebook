Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
    resource :timeline, only: [:show]
    resources :posts, only: [:new, :create, :destroy]
  end

  resources :posts, only: [:new, :create, :destroy] do
      resource :like, only: [:create, :destroy], defaults: { likeable: 'Post' }
      resources :comments, defaults: { commentable: 'Post' }
  end

  resources :comments do
    resource :like, only: [:create, :destroy], defaults: { likeable: 'Comment' }
  end

  # resources :friendings, only: [:create, :destroy]

  resource :session, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

end
