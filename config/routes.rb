Rails.application.routes.draw do
  root to: 'staticpages#home'
  get '/' => 'staticpages#home'
  # resources :staticpages
  get 'timeline' => 'staticpages#timeline'
  get 'friends' => 'staticpages#friends'
  get 'about' => 'staticpages#about'
  get 'photos' => 'staticpages#photos'

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users, :only => [:new, :create, :index]
end
