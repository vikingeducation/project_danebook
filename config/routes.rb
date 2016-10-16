Rails.application.routes.draw do
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'photos', to: 'static_pages#photos', as: 'photos'

  root :to => 'users#new'
  resources :users, only: [:new, :create, :show] do
    get 'about', on: :member
    get 'timeline', on: :member
    get 'friends', on: :member
  end
  resources :friendships, only: [:create, :destroy]
  resources :profiles, only: [:edit, :update]
  resources :posts, only: [:create, :update, :destroy] do
    get 'like', on: :member
    get 'unlike', on: :member
    resources :comments, only: [:create, :destroy] do
      get 'like', on: :member
      get 'unlike', on: :member
    end
  end

  resource :session, only: [:create, :destroy]
  delete "logout" => "sessions#destroy"
end
