Rails.application.routes.draw do
  get 'posts/index'

  # get 'posts/create'

  root "users#new"
  resources :users do
    resources :profiles , only: [:create, :destroy, :edit, :update]
    resources :posts, except: [:new, :show]
    resources :like, only: [:create,:destroy]
  end
  # bundle exec rake notes
  # TODO  move likes out of users, where user will always be current_user
  # shallow like 
  # TODO resources :like, as: :document, path: "document"
  # TODO rename polymorphic likes



  post "like/:user_id/:thing_id" => "like#create"
  delete "like/:user_id/:thing_id" => "like#destroy"

  get "user/:id/timeline" => "users#index"

  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
