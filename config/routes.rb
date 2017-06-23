Rails.application.routes.draw do
  root 'static_pages#home'

  get 'home' => 'static_pages#home'
  get 'timeline' => 'static_pages#timeline'
  get 'friends' => 'static_pages#friends'
  get 'about' => 'static_pages#about'
  get 'photos' => 'static_pages#photos'
  get 'about_edit' => 'static_pages#about_edit'

  resource :users, :only => [:new, :create]
  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  # resources :static_pages, :only => [:home, :timeline]
end
