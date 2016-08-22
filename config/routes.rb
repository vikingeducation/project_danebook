Rails.application.routes.draw do
  root to: 'users#new'
  resources :users, :except => [:update, :destroy] do
    resources :photos, :defaults => { :photoable => 'User'}, :only => [:create]
    resources :friendings, :only => [:index, :create, :index]

    resources :posts, :only => [:create, :destroy] do
      resources :photos, :defaults => { :photoable => 'Post'}, :only => [:create]
      resources :likings, :only => [:create]
    end
    resource :profiles, :except => [:create, :destroy] do
      resources :photos, :defaults => { :photoable => 'Profile'}, :only => [:create]
      get "/edit" =>  "profiles#show"
      get "/" =>  "profiles#index"
    end
  end

  resources :posts, :except => [:create, :destroy] do
    resources :comments, :defaults => { :commentable => 'Post'}
  end

  resources :timelines, :only => [:index]

  resources :friendings, :only =>  [:destroy]
  resources :likings, :only => [:destroy]
  resource :session, :only => [:new, :create, :destroy]

  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
