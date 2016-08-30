Rails.application.routes.draw do
  root 'users#new'
  get '/timeline' => 'users#timeline'
  get '/timeline/:id' => 'users#timeline'
  get '/friends' => 'static_pages#friends'
  get '/photos' => 'static_pages#photos'
  get '/about_edit' => 'static_pages#about_edit'


  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  resources :users, :only => [:new, :create, :show, :edit, :update, :timeline]
  resources :posts, :only => [:destroy, :update]
  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
