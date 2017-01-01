Rails.application.routes.draw do
  root 'users#new'

  resources :users do
    get 'friends'
    resource :profile, only: [:show]
    resources :posts,
              only: [:create, :destroy],
              shallow: true do
                resources :likes, only: [:create, :destroy], shallow: true
              end
    resources :comments,
              only: [:create, :destroy],
              shallow: true do
                resources :likes, only: [:create, :destroy], shallow: true
              end
    resources :photos,
              only: [:index, :new, :create, :destroy, :show],
              shallow: true do
                resources :likes, only: [:create, :destroy], shallow: true
              end
  end

  resources :friendings, only: [:create, :destroy]

  resource :profile, only: [:edit, :update] do
    patch 'set_picture'
    patch 'set_cover'
  end

  resource :newsfeed, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
