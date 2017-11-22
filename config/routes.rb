Rails.application.routes.draw do
  root 'users#new'
  
  resources :static_pages, :only => [:index]
  resources :users do
    resources :posts 
  end
  resource :sessions, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resources :likes
  resources :comments

  get "/static_pages/friends", to: "static_pages#friends", as: "friends"

  get "/static_pages/photos", to: "static_pages#photos", as: "photos"
end
