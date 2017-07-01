Rails.application.routes.draw do
  root 'users#new'

  get 'timeline' => 'static_pages#timeline'

  get 'friends' => 'static_pages#friends'
  get 'photos' => 'static_pages#photos'

  resources :users do
    resources :posts,  :only => [:index, :create, :destroy] do
      resources :comments, :defaults => { :commentable => 'Post' }
    end
    get 'timeline' => 'posts#index'
  end
  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

end
