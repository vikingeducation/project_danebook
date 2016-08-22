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

  resources :comments do
    resources :comments, defaults: {commentable: "Comment"}
    resources :likes, defaults: {likeable: "Comment"}
  end

  resources :photos do 
    resources :comments, defaults: {commentable: "Photo"}
    resources :likes, defaults: {likeable: "Photo"}
  end

  resources :relationships, only: [:create, :destroy]



  root "users#new"

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  get '*path' => redirect("/")
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
