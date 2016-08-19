Rails.application.routes.draw do

  get 'photos/new'

  get 'photos/create'

  get 'photos/destroy'

  get 'static_pages/home'

  get 'profiles/update'

  root 'static_pages#home'

  # Use # instead of / when mapping url to a custom path.
  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'  
  
  resources :users do
    get 'change_avatar'
  end

  resources :posts

  resources :photos do
    get 'serve'
  end

  resources :comments
  
  resources :likes

  resources :timelines

  resources :friends, only: [:index,:create]

  resources :activations, only: [:edit]

  resources :password_resets

  resources :profiles

end
