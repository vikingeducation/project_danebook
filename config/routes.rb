Rails.application.routes.draw do
  root to: 'users#new'
  resources :users, :except => [:index, :update, :destroy] do
    resources :posts do
      resources :likings, :only => [:create]
    end
    resource :profiles, :except => [:create, :destroy] do
      get "/edit" =>  "profiles#show"
      get "/" =>  "profiles#index"
      get "/timeline" => "profiles#timeline"

    end
  end



  resources :likings, :only => [:destroy]

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
