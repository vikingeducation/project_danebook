Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/timeline" => "static_pages#timeline"
  get "/friends" => "static_pages#friends"
  get "/about" => "static_pages#about"
  get "/photos" => "static_pages#photos"
  get "/about_edit" => "static_pages#about_edit"

  resources :users

  resource :session, :only => [:create, :destroy]

  get "login" => "static_pages#home"
  delete "logout" => "sessions#destroy"
end
