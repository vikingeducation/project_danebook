Rails.application.routes.draw do
  root to: "users#new"
  get '/home' => "staticpages#home"
  get '/timeline' => "staticpages#timeline"
  get '/friends' => "staticpages#friends"
  get '/about' => "staticpages#about"
  get '/photos' => "staticpages#photos"
  get '/about_edit' => "staticpages#about_edit"

  resources :users do
    resources :posts, only: [:index, :create, :destroy]
    resources :photos, except: [:edit, :update]
    resources :friends, only: [:index]
  end
  resource :likes, only: [:create, :destroy]
  resource :friendings, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resource :logins, only: [:new, :create, :destroy]
end
