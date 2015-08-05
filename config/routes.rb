Rails.application.routes.draw do
  root 'users#new'
  get '/' => 'staticpages#home'
  # resources :staticpages
  # get 'timeline' => 'staticpages#timeline'
  get 'friends' => 'staticpages#friends'
  # get 'about' => 'staticpages#about'
  get 'photos' => 'staticpages#photos'

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users do 
    resource :profile, :only => [:edit, :update, :show]
    get 'about' => 'profiles#show'

    resources :posts, :except => [:show]
    get 'timeline' => 'posts#index'
  end

end
