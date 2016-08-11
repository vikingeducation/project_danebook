Rails.application.routes.draw do

  root "static_pages#index"

  resources :users do
    resource :profile, only: [:show]
  end

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

end
