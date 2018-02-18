Rails.application.routes.draw do


  # root :to => 'posts#index', :constraints => lambda { |request| request.cookies['auth_token'].present? }, :defaults => { :user_id => 94 }
  root :to => 'users#new'

  resources :users do
    resources :posts,  :only => [:index, :new, :create, :destroy]
    resources :friends, :only => [:index]
    resources :photos
    get 'upload' => 'photos#new'
    get 'timeline' => 'posts#index'
    get 'search' => 'users#index'
    get 'newsfeed' => 'newsfeed#index'
  end

  resource :likes, :only => [:create, :destroy]
  resource :comments, :only => [:new, :create, :destroy]
  resource :session, :only => [:new, :create, :destroy]
  resource :friending, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

end
