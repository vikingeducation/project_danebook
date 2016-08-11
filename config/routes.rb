Rails.application.routes.draw do

  get 'posts/index'

  root 'users#new'

  resources :users do
    resource :timeline, only: [:show]
    resource :profile, only: [:show]
  end
  
  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

end
