Rails.application.routes.draw do
  
  #root "static_pages_controller#index"
  root to: 'users#new'
  
  resources :users do
    resource :profile, only: [:edit,:update,:show]
    resources :photos, except: [:edit]
    resources :posts, only: [:index,:create,:destroy]
    resources :friends, only: [:index]
  end
  
  resources :comments, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]
  resource :friendings, only: [:create, :destroy]
  
  resource :session, :only => [:new,:create,:destroy]
  get 'login' => 'session#new'
  delete 'logout' => 'session#destroy'

  get '*unmatched_route', to: 'application#raise_not_found'
end
