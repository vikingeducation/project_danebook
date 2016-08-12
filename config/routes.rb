Rails.application.routes.draw do
  root to: 'users#new'
  get '/home'     => 'users#new'
  get '/timeline' => 'static_pages#timeline'
  get '/friends'  => 'static_pages#friends'
  get '/about'    => 'users#show'
  get '/photos'   => 'static_pages#photos'
  get '/about_edit' => 'users#edit'

  resources :users
  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
end
