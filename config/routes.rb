Rails.application.routes.draw do
  root "users#new"
  resources :users do
    resource :profile, :only => [:show, :edit]
    resources :likes
  end
  resources :posts, :only => [:create, :destroy]
  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
