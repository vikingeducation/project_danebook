Rails.application.routes.draw do

  get 'posts/index'

  root 'users#new'

  resources :users do
    resource :timeline, only: [:show]
    resource :profile, only: [:show]
    resources :posts,
              only: [:create, :destroy],
              defaults: { likeable: 'Post', commentable: 'Post' },
              shallow: true do
                resources :likes, only: [:create, :destroy], shallow: true
              end
  end

  resource :profile, only: [:edit, :update]

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  delete "logout" => "sessions#destroy"

end
