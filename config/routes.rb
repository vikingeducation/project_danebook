Rails.application.routes.draw do

  root 'users#new'

  resources :users do

    resource :profiles, only: [:update]

    resources :posts do
      resources :comments
    end

    resources :photos do
      resources :comments
    end
    
  end

  resources :likes, only: [:create, :destroy]
  resources :friendings, only: [:create, :destroy]
  
  resource :session, only: [:new, :create, :destroy]

  get 'login' => 'users#new'
  get 'logout' => 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
