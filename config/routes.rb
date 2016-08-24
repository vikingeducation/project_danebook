Rails.application.routes.draw do
  root 'users#new'
  get '/timeline' => 'static_pages#timeline'
  get '/friends' => 'static_pages#friends'
  get '/photos' => 'static_pages#photos'
  get '/about' => 'users#about'
  get '/about_edit' => 'static_pages#about_edit'

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  resources :users, :only => [:new, :create, :show, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
