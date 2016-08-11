Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#new"

  resources :users do 
    resource :timeline, only: [:show]
  end

  resource :session, only: [ :new, :create, :destroy ]

  get '/friends' => "static_pages#friends"
  get '/photos' => "static_pages#photos"
  
end
