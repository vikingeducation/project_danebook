Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
    resource :timeline, only: [:show]
    resources :posts, only: [:new, :create, :destroy]
  end


  resources :posts, only: [:new, :create, :destroy] do
      resource :like, only: [:create, :destroy], :defaults => { :likeable => 'Post' } #only temporary!
  end

  #
  # resources :comments do
  #   resources :likes, only: [:create, :destroy], :defaults => { :likeable => 'Comment' }
  # end

  # resources :likes, :defaults => { :likeable => 'Like' }

  resource :session, only: [:new, :create, :destroy]


  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

end
