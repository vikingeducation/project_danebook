Rails.application.routes.draw do
  root 'users#new'
  
  resources :static_pages, :only => [:index]
  resources :users do
    resources :posts
  end
  resource :sessions, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"


  get "/static_pages/timeline", to: "static_pages#timeline", as: "timeline"


  # get "/posts/timeline", to: "posts#timeline", as: "timeline"

  get "/static_pages/about", to: "static_pages#about", as: "about"

  get "/static_pages/about_edit", to: "static_pages#about_edit", as: "about_edit"

  get "/static_pages/friends", to: "static_pages#friends", as: "friends"

  get "/static_pages/photos", to: "static_pages#photos", as: "photos"
end
