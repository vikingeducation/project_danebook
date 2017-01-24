Rails.application.routes.draw do

  root 'users#new'
  resources :users, :only => [:new, :create, :index, :edit, :update]
  resource :session, :only => [:new, :create, :destroy]

  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'

  get '/users/:id/about',
    to: 'users#about',
    as: 'about_user'

  get 'users/:id/timeline', 
      to: 'users#timeline', 
      as: 'user_timeline'


end
