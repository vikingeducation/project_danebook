Rails.application.routes.draw do
  get 'posts/index'

  root "users#new"
  resources :users do
    resources :profiles , only: [:create, :destroy, :edit, :update]
    resources :posts, except: [:new, :show]
  end

  get "user/:id/timeline" => "users#index"

  resources :likes, only: [:create,:destroy]
  resources :comments, only: [:create,:destroy]
  

 

  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
