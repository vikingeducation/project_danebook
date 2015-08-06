Rails.application.routes.draw do
  root to: "users#show"
  get '/home' => "staticpages#home"
  get '/timeline' => "staticpages#timeline"
  get '/friends' => "staticpages#friends"
  get '/about' => "staticpages#about"
  get '/photos' => "staticpages#photos"
  get '/about_edit' => "staticpages#about_edit"

  resources :users do
    resources :profiles, only: [:edit, :index, :update]
    resources :posts, only: [:new, :create, :index, :show, :destroy]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :comments, only: [:new, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :friendings, only: [:create, :index]
end
