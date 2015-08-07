Rails.application.routes.draw do

  resources :users do
    resource :profile
    resource :timeline
    resource :posts
  end
  
  resources :comments, :only => [:create, :destroy]
  resources :friendings, :only => [:create, :destroy]
  
  root to: 'users#new'

  get 'timeline' => 'users#timeline'
  get 'about' => 'users#about'
  post 'login' => 'sessions#create'
  get  'logout' => 'sessions#destroy'
  post "like" => "likes#create"
  delete "unlike"  => 'likes#destroy'
end
