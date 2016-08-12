Rails.application.routes.draw do
  root to: 'users#new'
  resources :users, :except => [:update, :destroy] do
    resources :posts
    resource :profiles, :except => [:create, :destroy] do
      get "/edit" =>  "profiles#show"
      get "/" =>  "profiles#index"
      get "/timeline" => "profiles#timeline"
    end
  end

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
