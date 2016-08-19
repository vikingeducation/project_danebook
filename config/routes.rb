Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#new"

  resources :users do 
    resource :timeline, only: [:show]
    resource :friends, only: [:show]
    resource :photos, only: [:show]

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

  get '/friends' => "static_pages#friends"
  get '/photos' => "static_pages#photos"
  
end
