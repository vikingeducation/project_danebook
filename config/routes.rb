Rails.application.routes.draw do
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'photos', to: 'static_pages#photos', as: 'photos'

  root :to => 'users#new'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:create, :destroy]
end
