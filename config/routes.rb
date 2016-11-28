Rails.application.routes.draw do

  root 'users#new'

  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'photos', to: 'static_pages#photos', as: 'photos'

  resources :likes, only: [:create, :destroy]

  resources :posts, only: [:show, :create, :destroy]

  resources :users do
    get '/timeline' => 'posts#index'
    resource :profile, only: [:edit, :update, :show]
  end

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => "users#new"
  delete 'logout' => "sessions#destroy"

end
