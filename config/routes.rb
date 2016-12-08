Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#new"
  resources :users do
    resource :profile, on: :member, except: [:new, :create, :destroy]
  end
end
