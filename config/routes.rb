Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users'
  }
  authenticated :user do
    root 'newsfeed#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  get 'newsfeed', to: 'newsfeed#index'
  resources :users,  only: [:new, :create, :update, :edit, :index] do
    get 'about' => 'users#show'
    get 'profile' => 'posts#index'
    resources :photos, only: [:create, :index, :destroy] do
      get 'upload' => 'photos#new', on: :collection
    end
    resources :posts, only: [:new, :create, :destroy]
    resources :friendships, path: 'friends', as: 'friends', only: [:create, :destroy, :index] do
    end
  end
  resources :photos, only: [:show, :destroy] do
    patch 'cover' => 'profiles#update', on: :member, defaults: {photo_type: 'Cover'}
    patch 'avatar' => 'profiles#update', on: :member, defaults: {photo_type: 'Avatar'}
    resources :comments, only: [:create], defaults: { commentable: 'Photo'}
    resources :likes, only: [:create, :destroy], defaults: { likeable: 'Photo'}
  end
  resources :posts, only: [] do
    resources :likes, only: [:create, :destroy], defaults: { likeable: 'Post'}
    resources :comments, only: [:create], defaults: { commentable: 'Post'}
  end
  resources :comments, only: [:destroy] do
    resources :comment_likes, only: [:create, :destroy]
  end
  resources :friendships, path: 'friends', as: 'friends', only: [:destroy] do
    patch 'accept' => 'friendships#update', on: :member
    patch 'reject' => 'friendships#update', on: :member
    patch 'cancel' => 'friendships#update', on: :member
  end


end
