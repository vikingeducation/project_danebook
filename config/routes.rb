Rails.application.routes.draw do
  root :to => 'users#new'

  resources :users do
    resources :posts,  :only => [:index, :new, :create, :destroy]
    resources :friends, :only => [:index, :show]
    resources :photos
    get 'upload' => 'photos#new'
    get 'timeline' => 'posts#index'
    get 'search' => 'friends#index'
    get 'newsfeed' => 'newsfeed#index'
  end

  resource :likes, :only => [:create, :destroy]
  resource :comments, :only => [:new, :create, :destroy]
  resource :session, :only => [:new, :create, :destroy]
  resource :friending, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

end
