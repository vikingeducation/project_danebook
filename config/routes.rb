Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'static_pages#home'
  get "/home", to: 'static_pages#home'
  get "/timeline", to: 'static_pages#timeline'
  get "/friends", to: 'static_pages#friends'
  get "/about", to: 'static_pages#about'
end
