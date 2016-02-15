Rails.application.routes.draw do

  resources :users, only: [:new, :create, :update, :show]
  resources :profiles, only: [:show, :edit, :update]
  resource :session, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy] do
    resources :likes, only: [:create, :destroy], defaults: { likeable: 'Post' }
  end 
  root 'users#new', as: :signup

end
