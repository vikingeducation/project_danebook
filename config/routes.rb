Rails.application.routes.draw do
  get 'posts/index'

  get 'posts/create'

  root "users#new"
  resources :users do
    resources :profiles , only: [:create, :destroy, :edit, :update]
    resources :posts, except: [:new, :show]
  end

  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
