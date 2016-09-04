Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :update, :edit, :show]
  get "signup" => "users#new"
  root 'users#new'

  resource :sessions, only: [:create, :destroy]
  delete "logout" => "sessions#destroy"

  resources :posts do
    member do
      post 'like'
      delete 'unlike'
    end
  end
end
