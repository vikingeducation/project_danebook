Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  resource :session
  resources :users do
    resource :profile
    # resources :galleries
    resources :friends
    resources :posts do
      resource :comment, only: [:create, :new]
    end
  end
  resources :likes, only: [:update, :destroy]

  get '/search' => 'search#show'
  get '/signup' => 'users#new'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#new'
  match via: [:get, :post], "*path" => redirect("/")
end
