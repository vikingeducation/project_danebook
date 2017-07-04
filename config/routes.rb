Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  get "/users/search" => "users#search"
  resources :users do
    resources :photos, only: [:index, :new, :create, :show, :destroy] do
      post "/set-profile" => "photos#set_profile"
      post "/set-cover" => "photos#set_cover"
      resources :comments, defaults: {commentable: "Photo"}, only: [:create, :destroy]
      resources :likes, defaults: {likable: "Photo"}, only: [:create, :destroy]
    end
    resources :posts
    get '/friends' => "friend_requests#index"
    get "/newsfeed" => "static_pages#newsfeed"

  end


  resources :friend_requests, only: [:index, :create, :update, :destroy]

  resources :posts do
    resources :likes, defaults: {likable: "Post"}, only: [:create, :destroy]
    resources :comments, defaults: {commentable: "Post"}, only: [:new, :create, :destroy]
  end

  resources :comments do
    resources :likes, defaults: {likable: "Comment"}, only: [:create, :destroy]
  end


  resource :session, only: [:new, :create, :destroy]
  get "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/" => "static_pages#home"

end
