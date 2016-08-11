Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#new"

  post "login" => "sessions#create"
  post "logout" => "sessions#destroy"

  resources :users do
    member do
      get :about
    end

    resources :photos
    resources :friends
  end
  resource :session, :only => [:new, :create, :destroy]
end
