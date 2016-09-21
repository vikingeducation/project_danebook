Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#new"

  resources :newsfeed, only: [:index]
  resources :users do 
    resource :timeline, only: [:show]
    resources :friends, only: [:index]
  end

  resources :photos

  resources :likes, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

  resource :session, only: [ :new, :create, :destroy ]
  resources :friendings, only: [:create, :destroy]

  
  
end
