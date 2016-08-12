Rails.application.routes.draw do

  root "users#index"

  resources :users do
    resource :profile, only: [:show]
    resources :posts, only: [:create, :destroy]
    get "timeline" => "users#show"
  end

  resource :profile, only: [:edit, :update]

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resource :static_pages

end
