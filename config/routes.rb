Rails.application.routes.draw do

  root 'users#new'


  resources :users, only: [:new, :create, :show] do
    resource :profile, only: [:create, :show, :edit, :update]
    resources :posts
  end

  resources :friendings, :only => [:index, :create, :destroy]
  resource :session, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]

  get "login" => "users#new"
  delete "logout" => "sessions#destroy"

  post "like" => "likes#create"
  delete "unlike"  => 'likes#destroy'


  # OLD STATIC ROUTES BELOW (remove after all dynamic pages work)
  #==============================================================

  # get 'about' => 'static_pages#about'
  # get 'about' => 'profile#show'
  get 'timeline' => 'static_pages#timeline'
  get 'friends' => 'static_pages#friends'
  get 'about_edit' => 'static_pages#about_edit'
  get 'photos' => 'static_pages#photos'

end
