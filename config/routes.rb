Rails.application.routes.draw do


  get 'comments/new'

  resources :users do
    resource :profiles, only: [:edit, :show, :update]
    resources :posts, only: [:create, :destroy]
    resources :photos
  end 

  resources :posts do
    resources :comments, defaults: {commentable: "Post"}
    resources :likes, defaults: {likeable: "Post"}
  end

  resource :comments do
    resources :comments, defaults: {commentable: "Comment"}
    resources :likes, defaults: {likeable: "Comment"}
  end





  root "users#new"

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
