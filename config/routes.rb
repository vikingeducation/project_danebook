Rails.application.routes.draw do

  resources :users, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :posts, only: [:new, :create, :destroy, :index] do
    end  
  end  
  resources :comments,  only: [:create, :destroy]
  resources :likes,  only: [:create, :destroy]
  resources :friendships,  only: [:create, :destroy]

  resource :session, :only => [:new, :create, :destroy]
    get "login" => "sessions#new"
    delete "logout" => "sessions#destroy"

  resources :friendships, :only => [:index, :new, :create, :destroy]
  resources :images, :only => [:index, :new, :show, :create, :destroy]
  resources :profiles, :only => [:update]

  get "search" => "users#search"
  get "newsfeed/:user_id" => "posts#newsfeed" , as: "newsfeed"

  root 'users#new'
  
end
