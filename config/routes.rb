Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  resource :session, only: [:create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  resources :users do
    get '/home', to: 'users/static_pages#home'
    get '/timeline', to: 'posts#index', as: '/timeline'
    get '/friends', to: 'users#friends', as: '/friends'
    resource :profile, only: [:show, :edit, :update, :create]
    resources :posts, except: [:index, :edit, :update]
    resources :photos, except: [:edit, :update]
  end
  resource :like, only: [:create, :destroy]
  resources :posts, only: [:index] do
    resources :comments, except: [:edit, :update, :show]
  end

  resource :friendship, only: [:create, :destroy]

end
