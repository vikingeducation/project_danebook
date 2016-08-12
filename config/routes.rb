Rails.application.routes.draw do

  get 'static_pages/home'

  get 'profiles/update'

  root 'static_pages#home'

  # Use # instead of / when mapping url to a custom path.
  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'  
  
  resources :users do
    resources :posts do
      resources :comments, :likes
    end
    resource :timelines, only: [:show]
  end

  resources :friends, only: [:index,:create]

  resources :activations, only: [:edit]

  resources :password_resets

  resources :profiles

end
