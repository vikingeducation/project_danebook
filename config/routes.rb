Rails.application.routes.draw do

  root "users#index"

  resources :users do
    resource :profile, only: [:show]
    resources :posts, only: [:create, :destroy]
    get "timeline" => "users#show"
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy, :index, :new, :show]
  end

  resource :profile, only: [:edit, :update]

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

  resource :static_pages, only: [:index, :show, :new]

  resources :friendings, :only => [:create, :destroy, :show]

end
