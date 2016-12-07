Rails.application.routes.draw do
  root "users#new"
  resources :users
  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
