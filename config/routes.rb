Rails.application.routes.draw do
  
  root "static_pages_controller#index"

  get 'about', to: 'static_pages_controller#about', as: 'about'

  get 'about_edit', to: 'static_pages_controller#about_edit', as: 'about_edit'

  get 'friends', to: 'static_pages_controller#friends', as: 'friends'

  get 'photos', to: 'static_pages_controller#photos', as: 'photos'

  get 'timeline', to: 'static_pages_controller#timeline', as: 'timeline'




end
