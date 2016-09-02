Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'timeline', to: 'static_pages#timeline'
  get 'friends',  to: 'static_pages#friends'
  get 'about',    to: 'static_pages#about'
  get 'photos',   to: 'static_pages#photos'
  get 'about_edit', to: 'static_pages#about_edit'
end
