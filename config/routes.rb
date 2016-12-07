Rails.application.routes.draw do
  root "users#new"
  resources :users
  resources :session, :only => [:new, :create, :destroy]
  get "login" => "session#new"
  delete "logout" => "session#destroy"
end
