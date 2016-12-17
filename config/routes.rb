Rails.application.routes.draw do
  root "users#new"
  resources :users do
    resource :profile, :only => [:show, :edit]
  end
  resources :posts, :only => [:create, :destroy] do
    resources :likes
  end
  resources :comments do
    resources :likes
  end
  resources :photos
  resource :session, :only => [:create, :destroy]
  resources :friendings, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
