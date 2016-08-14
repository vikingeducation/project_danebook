Rails.application.routes.draw do
  root to: "static_pages#home"
  get "/friends" => "static_pages#friends"
  get "/photos" => "static_pages#photos"

  resources :users, :except => [:new, :delete] do
    resources :activities, :only => [:index, :destroy]
    resources :posts, :only => [:create]
    resources :friendings, :only => [:create]
  end

  resources :friendings, :only => [:destroy]

  resources :activities, :only => [] do
    resources :likings, :only => [:create]
    resources :comments, :only => [:create]
  end

  resources :likings, :only => [:destroy]

  resource :session, :only => [:create, :destroy]

  get "login" => "static_pages#home"
  delete "logout" => "sessions#destroy"
end
