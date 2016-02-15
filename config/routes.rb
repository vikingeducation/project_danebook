Rails.application.routes.draw do

  resources :users, only: [:new, :create, :edit, :show, :destroy] do
    resources :posts, only: [:new, :create, :destroy, :index] do
      resources :comments, :defaults => { :commentable => 'Comment' }, only: [:create, :destroy]
      resources :likes, :defaults => { :likeable => 'Post' }, only: [:create, :destroy]
    end  
  end  

  resource :session, :only => [:new, :create, :destroy]
    get "login" => "sessions#new"
    delete "logout" => "sessions#destroy"

  root 'users#new'
  
end
