Rails.application.routes.draw do

  root 'users#new'

  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'

  resources :users, 
            :only => [:new, :create, :edit, :update] do

  resources :posts, :only => [:create, :destroy]
    get '/timeline' => 'posts#index'
  end
  
  resource :session, :only => [:new, :create, :destroy]

  resources :comments, :likes, :only => [:create, :destroy]

  get '/users/:id/about',
    to: 'users#about',
    as: 'about_user'


end
