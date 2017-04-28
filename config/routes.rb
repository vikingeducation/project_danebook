Rails.application.routes.draw do
  devise_for :users,
  controllers: {
    # sessions: 'users/sessions',
    registrations: 'users'
  }


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  get 'home', to: 'static_pages#home', as: 'home'
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'photos', to: 'static_pages#photos', as: 'photos'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'about_edit', to: 'static_pages#about_edit', as: 'about_edit'
  resources :users,  only: [:new, :create, :update, :edit ] do
    get 'about' => 'users#show'
    get 'profile' => 'posts#index'
    resources :photos, only: [:create, :show, :index] do
      get 'upload' => 'photos#new', on: :collection
    end
    resources :posts, only: [:new, :create, :destroy]
    resources :friendships, path: 'friends', as: 'friends', only: [:create, :destroy, :index, :update]
  end
  resources :posts, only: [] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end
  resources :comments, only: [:destroy] do
    resources :comment_likes, only: [:create, :destroy]
  end


end
