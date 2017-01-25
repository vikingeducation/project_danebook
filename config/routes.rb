Rails.application.routes.draw do

  root 'users#new'
  resources :users, 
            :only => [:new, :create, :index, :edit, :update] do

    resources :posts, :only => [:create, :destroy]
    get '/timeline' => 'posts#index'
  end
  resource :session, :only => [:new, :create, :destroy]

  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'

  get '/users/:id/about',
    to: 'users#about',
    as: 'about_user'




end
