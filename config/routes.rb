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
  
  resources :photos do
    resources :likes
  end

  resource :session, :only => [:create, :destroy]
  resources :friendings, :only => [:create, :destroy, :index]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
  get "set_profile_pic" => "profiles#set_profile_pic"
  get "unset_profile_pic" => "profiles#unset_profile_pic"
  get "set_cover_photo" => "profiles#set_cover_photo"
  get "unset_cover_photo" => "profiles#unset_cover_photo"
end
