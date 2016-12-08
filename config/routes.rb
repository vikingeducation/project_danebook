Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
  end

  resource :session, only: [:new, :create, :destroy]

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

end
