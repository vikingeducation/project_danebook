Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
    resource :timeline, only: [:show]
    resources :posts, only: [:new, :create, :destroy]
    resources :comments
  end


  resources :posts, only: [:new, :create, :destroy] do
      resource :like, only: [:create, :destroy], :defaults => { :likeable => 'Post' }
      resource :comment, only: [:create, :destroy], :defaults => { :commentable => 'Post' }
  end

  resources :comments do
    resource :like, only: [:create, :destroy], :defaults => { :likeable => 'Comment' }
    resource :comment, only: [:create, :destroy], :defaults => { :commentable => 'Comment' }
  end



  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

end
