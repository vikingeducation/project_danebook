Rails.application.routes.draw do
  root "static_pages#home"
  get "timeline" => "static_pages#timeline"
  #get "friends" => "static_pages#friends"
  get "about" => "static_pages#about"
  get "photos" => "static_pages#photos"
  get "about_edit" => "static_pages#about_edit"
  resources :users do
    resources :posts
    resources :friends, :only => [:index]
  end
  resources :posts, :only=>[] do
    resources :likes, :only=>[:create,:destroy]
    resources :comments, :only=>[:create, :destroy]
  end
  resources :comments, :only=>[] do
    resources :likes, :only=>[:create,:destroy]
  end
  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resource :friendings, :only => [:create, :destroy]

  #get "friends" => "users#friends"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
