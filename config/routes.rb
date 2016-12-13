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

  # resources :comments do
    # resource :like, only: [:create, :destroy], defaults: { likeable: 'Comment' }
    # resource :comment, :defaults => { :commentable => 'Comment' }
  # end

  resources :friendings, only: [:create, :destroy]

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'
  #
  # get 'comment_create' => 'comments#new'
  # post 'comment/:post_id' => 'comments#create'

end
