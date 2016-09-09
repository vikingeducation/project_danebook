Rails.application.routes.draw do
  root 'users#new'
  get '/timeline' => 'users#timeline'
  get '/timeline/:id' => 'users#timeline'


  get '/about_edit' => 'static_pages#about_edit'
  get '/friends' => 'users#friends'

  get '/photos' => 'static_pages#photos'
  get '/photos/:id' => 'static_pages#photos'


  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  resources :users, :only => [:new, :create, :show, :edit, :friends, :update, :timeline, :index] do
    resources :photos
  end

  resources :posts, :only => [:destroy, :update]
  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]
  resources :friendings, :only => [:create, :destroy]
  resources :covers, :only => [:create, :update]
  resources :profiles, :only => [:create, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
