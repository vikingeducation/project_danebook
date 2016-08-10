Rails.application.routes.draw do

  get 'posts/index'

  root 'static_pages#home'

  resources :users do
    resource :timeline, only: [:show]
  end
  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

end
