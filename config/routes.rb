Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create]
  get "signup" => "users#new"

  resource :sessions, only: [:create, :destroy]
  delete "logout" => "sessions#destroy"
end
