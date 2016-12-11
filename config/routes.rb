Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#new"
  resources :users, shallow: true do
    resource :profile, on: :member, except: [:new, :create, :destroy, :index]
    resources :posts do
      get "delete" => "posts#destroy"
      get "likes" => "likes#index"
      get "like" => "likes#create"
      get "unlike" => "likes#destroy"
      resources :comments do
        get "delete" => "comments#destroy"
        get "likes" => "likes#index"
        get "like" => "likes#create"
        get "unlike" => "likes#destroy"
      end
    end
  end

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
end
