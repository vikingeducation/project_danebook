Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#new"
  resources :users, shallow: true do
    resource :profile, on: :member, except: [:new, :create, :destroy, :index]
    get "friend" => "friends#create"
    get "unfriend" => "friends#destroy"
    get "friends" => "friends#index"
    resources :posts do
      get "likes" => "likes#index"
      get "like" => "likes#create"
      get "unlike" => "likes#destroy"
      resources :comments do
        get "likes" => "likes#index"
        get "like" => "likes#create"
        get "unlike" => "likes#destroy"
      end
    end
    resources :photos, except: [:edit, :update]
  end

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
end
