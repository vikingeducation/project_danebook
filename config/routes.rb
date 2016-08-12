Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/friends" => "static_pages#friends"
  get "/photos" => "static_pages#photos"

  resources :users, :except => [:new] do
    resources :activities
  end

  resource :session, :only => [:create, :destroy]

  get "login" => "static_pages#home"
  delete "logout" => "sessions#destroy"
end
