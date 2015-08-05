Rails.application.routes.draw do

  resources :users do
    resource :profile
    resource :timeline
    resource :posts
  end
  
  root to: 'users#new'

  get 'timeline' => 'users#timeline'

  get 'about' => 'users#about'

  post 'login' => 'sessions#create'
  get  'logout' => 'sessions#destroy'
  
end
