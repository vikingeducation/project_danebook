Rails.application.routes.draw do

  resources :users, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :posts, only: [:new, :create, :destroy, :index] do
    end  
  end  
  resources :comments, :defaults => { :commentable => 'Post'}, only: [:create, :destroy]
  resources :likes, :defaults => { :likeable => 'Post' }, only: [:create, :destroy]

  resource :session, :only => [:new, :create, :destroy]
    get "login" => "sessions#new"
    delete "logout" => "sessions#destroy"

  root 'users#new'
  
end
