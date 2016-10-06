Rails.application.routes.draw do
  root 'static_pages#home'
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
end
