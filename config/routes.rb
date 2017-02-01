Rails.application.routes.draw do

  root 'users#new'

  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'photos', to: 'static_pages#photos', as: 'photos'

  resources :likes, :comments, only: [:create, :destroy]

  resources :posts, only: [:index]

  resources :photos, :only => [:show, :new, :create] do
    get "serve"  #photo_serve_path, e.g. /photos/1/serve
  end

  resources :users do
    get '/timeline' => 'posts#index'
    resource :profile, only: [:edit, :update, :show]
    resources :friendings, only: [:index, :create, :destroy]
    resources :photos, only: [:show, :new, :create, :index, :destroy] do
      get "serve"
    end
  end

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => "users#new"
  delete 'logout' => "sessions#destroy"

end
