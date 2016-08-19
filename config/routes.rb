Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#new"

  resources :users do 
    resource :timeline, only: [:show]
    resources :friends, only: [:index]
    resources :photos

  end
  resources :posts do
    resources :likes, only: [:create, :destroy]
    resources :comments 
  end

  resources :comments do
    resources :likes, only: [:create, :destroy]
    resources :comments
  end

  resource :session, only: [ :new, :create, :destroy ]
  resources :friendings, only: [:create, :destroy]

  
  
end
