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
  get 'home', to: 'static_pages#home', as: 'home'
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'photos', to: 'static_pages#photos', as: 'photos'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'about_edit', to: 'static_pages#about_edit', as: 'about_edit'
  get 'newsfeed', to: 'newsfeed#index'
  # get 'newsfeed' => 'users#index'
  resources :users,  only: [:new, :create, :update, :edit ] do
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
    patch 'cover' => 'profiles#update', on: :member
    patch 'avatar' => 'profiles#update', on: :member
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
