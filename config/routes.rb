Rails.application.routes.draw do
  root :to => 'users#new'

  # get 'timeline' => 'static_pages#timeline'
  # get 'friends' => 'static_pages#friends'
  get 'photos' => 'static_pages#photos'

  resources :users do
    resources :posts,  :only => [:index, :new, :create, :destroy]
    resources :friends, :only => [:index, :show]
    get 'timeline' => 'posts#index'
    get 'search' => 'friends#index'
  end
  resource :likes, :only => [:create, :destroy]
  resource :comments, :only => [:new, :create, :destroy]
  resource :session, :only => [:new, :create, :destroy]
  resource :friending, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

end
