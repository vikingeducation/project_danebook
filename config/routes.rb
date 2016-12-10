Rails.application.routes.draw do

  root 'users#new'

  resources :users do
    resource :profile
    resource :timeline, only: [:show]
    resource :posts, only: [:new, :create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]


  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

end


#
# Rails.application.routes.draw do


#   root   'static_pages#home'
#   get    '/help',    to: 'static_pages#help'
#   get    '/about',   to: 'static_pages#about'
#   get    '/contact', to: 'static_pages#contact'
#   get    '/signup',  to: 'users#new'
#   get    '/login',   to: 'sessions#new'
#   post   '/login',   to: 'sessions#create'
#   delete '/logout',  to: 'sessions#destroy'
#   resources :users
# end
