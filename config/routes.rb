Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  resource :session
  resources :users do
    resource :profile
    resource :galleries
    resource :friends
  end
  get '/signup' => 'users#new'
  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#new'
end
