Rails.application.routes.draw do

  root 'sessions#new'

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  # users
  resources :users do
    resources :posts do
      resources :likes
      resources :comments, :defaults => { :commentable => 'Post' }
    end
    resources :timelines, only: [:index]
    resources :friends, only: [:index]
  end

  resources :friendings, :only => [:create, :destroy]

  # pages
  get 'pages/home'
  get '/home' => 'pages#home', as: 'home'

  get 'pages/my_feed'
  get '/my_feed' => 'pages#my_feed', as: 'my_feed'

  get 'pages/fakelook'
  get '/fakelook' => 'pages#fakelook_index', as: 'fakelook'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
