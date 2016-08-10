Rails.application.routes.draw do

  get 'profiles/update'

  root 'static_pages#home'

  # Use # instead of / when mapping url to a custom path.
  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'  
  
  resources :users

  resources :activations, only: [:edit]

  resources :password_resets

  resources :profiles

end
