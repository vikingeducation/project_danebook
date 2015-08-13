Rails.application.routes.draw do

  resources :users, only: [:new, :create,:index] do
    resource :profile
    resource :timeline
    resource :posts
    resources :photos
    resources :friendings, only: [:index]
  end


  resources :comments, :only => [:create, :destroy]
  # resources :friendings, :only => [:create, :destroy]
  
  root to: 'users#new'
  
  get 'accept' => 'friendings#accept'
  get 'decline' => 'friendings#decline'
  get 'friendings' => 'friendings#create'
  get 'timeline' => 'users#timeline'
  get 'about' => 'users#about'
  post 'login' => 'sessions#create'
  get  'logout' => 'sessions#destroy'
  post "like" => "likes#create"
  delete "unlike"  => 'likes#destroy'


  # get "*path", to: redirect { |p, req| req.flash[:error] = "Oh snaps you dont want to go there "; '/' }
end
