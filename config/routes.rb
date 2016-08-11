Rails.application.routes.draw do

  get 'profile/edit'

  get 'profile/update'

  get 'profile/show'

  get 'profile/destroy'

  resources :users do
    resources :profiles 
  end

  root "users#new"

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
