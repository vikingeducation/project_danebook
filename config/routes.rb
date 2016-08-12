Rails.application.routes.draw do

  root "static_pages#index"

  resources :users do
    resource :profile, only: [:show, :edit, :update]
    resources :posts, only: [:create, :destroy]
    get "timeline" => "users#show"
  end

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

end
