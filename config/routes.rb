Rails.application.routes.draw do

  resources :users, only: [:new, :create, :update, :show]
  resources :friendings, :only => [:create, :destroy, :show]
  resources :profiles, only: [:show, :edit, :update]
  resource :session, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy] do
    resources :likes, only: [:create, :destroy], defaults: { likeable: 'Post' }
    resources :comments, only: [:create, :destroy], defaults: { commentable: 'Post'} do
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'Comment' }
    end
  end

  resources :photos, only: [:index, :new, :create, :show, :destroy] do
    resources :likes, only: [:create, :destroy], defaults: { likeable: 'Photo' }
    resources :comments, only: [:create, :destroy], defaults: { commentable: 'Photo'} do
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'Comment' }
    end
  end
  root 'users#new', as: :signup
  get '/newsfeed' => 'users#newsfeed'
end
