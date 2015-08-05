Rails.application.routes.draw do

  get 'about', to: 'static_pages_controller#about', as: 'about'

  get 'about_edit', to: 'static_pages_controller#about_edit', as: 'about_edit'

  get 'friends', to: 'static_pages_controller#friends', as: 'friends'

  get 'photos', to: 'static_pages_controller#photos', as: 'photos'

  root "users#new"

  resources :users do
    resources :posts
  end

  resources :profiles

  resource :session, :only => [:new, :create, :destroy]

  get "login" => "sessions#new"

  get "timeline", to: "timelines#show", as: "timeline"

  delete "logout" => "sessions#destroy"


end
