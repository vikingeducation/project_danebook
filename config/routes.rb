Rails.application.routes.draw do
  root to: "sessions#new"

  resources :users, :except => [:new, :delete] do
    resources :activities, :only => [:index, :destroy]
    resources :posts, :only => [:create]
    resources :friendings, :only => [:create, :index]
    resources :photos, :only => [:new, :create, :index, :show]
    resources :timelines, :only => [:index]
  end

  get '/auth/github/callback' => "sessions#create"
  resources :friendings, :only => [:destroy]

  resources :activities, :only => [] do
    resources :likings, :only => [:create]
    resources :comments, :only => [:create]
  end

  resources :likings, :only => [:destroy]

  resource :session, :only => [:create, :destroy, :new]

  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
end
