Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
    resource :timeline, only: [:show]
    resources :photos
    resources :friendings, only: [:index, :create, :destroy]
    resources :posts, only: [:new, :create, :destroy]
  end

  resources :posts, only: [:new, :create, :destroy] do
      resource :like, only: [:create, :destroy], defaults: { likeable: 'Post' }
      resources :comments, defaults: { commentable: 'Post' }
  end

  resources :comments do
    resource :like, only: [:create, :destroy], defaults: { likeable: 'Comment' }
  end

  resources :friendings, only: [:create, :destroy]

  resource :session, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'set_avatar' => 'photos#set_avatar'
  get 'set_banner' => 'photos#set_banner'
end
