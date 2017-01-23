Rails.application.routes.draw do

  root 'users#new'
  resources :users, :only => [:new, :create, :index, :edit] 
  resource :session, :only => [:new, :create, :destroy]

  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'

end
