Rails.application.routes.draw do

  root 'users#new'


  resources :users, only: [:new, :create, :show, :update] do
    resource :profile, only: [:create, :show, :edit, :update]
    resources :posts, only: [:index, :create, :destroy]
    resources :photos, only: [:index, :show, :new, :create, :destroy]
  end

  resources :friendings, :only => [:create, :destroy, :index]
  resource :session, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]
  resource :search, :only => [:show]

  get "login" => "users#new"
  delete "logout" => "sessions#destroy"

  post "like" => "likes#create"
  delete "unlike"  => 'likes#destroy'

  get '*path' => redirect('/')
  # OLD STATIC ROUTES BELOW (remove after all dynamic pages work)
  #==============================================================

  # get 'about' => 'static_pages#about'
  # get 'about' => 'profile#show'
  # get 'timeline' => 'static_pages#timeline'
  # get 'friends' => 'static_pages#friends'
  # get 'about_edit' => 'static_pages#about_edit'
  # get 'photos' => 'static_pages#photos'

end
