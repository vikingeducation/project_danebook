Rails.application.routes.draw do
  root 'static_pages#home'
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'photos', to: 'static_pages#photos', as: 'photos'
end
