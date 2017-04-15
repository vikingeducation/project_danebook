Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  get 'home', to: 'static_pages#home', as: 'home'
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'photos', to: 'static_pages#photos', as: 'photos'
  # get 'about', to: 'static_pages#about', as: 'about'
  get 'about_edit', to: 'static_pages#about_edit', as: 'about_edit'
  resources :users,  only: [:new, :create, :edit, :update] do
    get 'about' => 'users#show'
  end


end
