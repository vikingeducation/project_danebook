Rails.application.routes.draw do
  get 'posts/index'

  # TODO Put a link to an user's timeline in their about page. Figure out what's up with the render. 

  root "users#new"
  resources :users do
    resources :profiles , only: [:create, :destroy, :edit, :update]
    resources :posts, except: [:new, :show]
    resources :friends, only: [:index]
  end

  get "user/:id/timeline" => "users#index"

  resources :likes, only: [:create,:destroy]
  resources :comments, only: [:create,:destroy]
  resources :friends, only: [:create,:destroy]
  

 

  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
