Rails.application.routes.draw do

  root 'static_pages#home'
  get 'static_pages/about'
  get 'static_pages/friends'
  get 'static_pages/photos'

  resources :users


end
