Rails.application.routes.draw do
  
  #root "static_pages_controller#index"
  root 'users#new'
  get '/', to: 'static_pages_controller#index'
  get 'about', to: 'static_pages_controller#about', as: 'about'

  get 'about_edit', to: 'static_pages_controller#about_edit', as: 'about_edit'

  get 'friends', to: 'static_pages_controller#friends', as: 'friends'

  get 'photos', to: 'static_pages_controller#photos', as: 'photos'

  get 'timeline', to: 'static_pages_controller#timeline', as: 'timeline'

  resource :session, :only => [:new,:create,:destroy]
  
  get 'login' => 'session#new'
  delete 'logout' => 'session#destroy'
  
  resources :users do
    resource :profile, :only => [:edit,:update,:show]
    get 'friends' => 'user#friends'
  end
  resources :comments, only: [:create, :destroy]
  resource :likes, only: [:create, :destroy]
  resources :users, except: [:index] do
    resources :posts
  end
end
