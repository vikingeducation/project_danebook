Rails.application.routes.draw do
  root 'users#new'
  get '/' => 'staticpages#home'
  # resources :staticpages
  get 'timeline' => 'staticpages#timeline'
  get 'friends' => 'staticpages#friends'
  get 'about' => 'staticpages#about'
  get 'photos' => 'staticpages#photos'

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users do 
    resources :profiles, :only => [:edit, :update, :show]
  end

end
