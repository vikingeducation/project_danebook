Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  resource :session, only: [:create]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  resources :users do
    get "/home", to: 'users/static_pages#home'
    get "/timeline", to: 'users/static_pages#timeline', as: '/timeline'
    get "/friends", to: 'users/static_pages#friends', as: '/friends'
    get "/about", to: 'users/static_pages#about', as: '/about'
    get "/photos", to: 'users/static_pages#photos', as: '/photos'
    get "/about_edit", to: 'users/static_pages#about_edit', as: '/about_edit'
  end
end
