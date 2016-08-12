Rails.application.routes.draw do


  get 'comments/new'

  resources :users do
    resource :profiles
    resources :posts
    resources :photos
  end

  root "users#new"

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
