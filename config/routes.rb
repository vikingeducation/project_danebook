Rails.application.routes.draw do
  get 'profiles/:id/show' => 'profiles#show'

  root to: 'newsfeed#show'
  get '/home'     => 'users#new'
  get '/timeline' => 'posts#index'
  get '/about'    => 'users#show'
  get '/friends' => 'friendings#index'
  get '/about_edit' => 'users#edit'
  get '/newsfeed' => 'newsfeed#show'

  get '/users/:user_id/timeline' => 'posts#index', as: '/user_timeline'
  get '/users/:user_id/about' => 'users#show', as: '/user_about'
  get '/users/:user_id/about_edit' => 'users#edit', as: '/user_about_edit'
  get '/users/:user_id/friends' => 'friendings#index', as: '/user_friends'
  get '/users/:user_id/photos' => 'photos#index', as: '/user_photos'

  resources :search_results, only: [ :index ]
  resources :users
  resources :photos do
    resources :likes, shallow: true
    resources :comments, shallow: true
  end
  resources :posts, only: [ :create, :destroy ] do
    resources :likes, shallow: true
    resources :comments
  end
  resources :comments, only: [ :destroy ] do
    resources :likes, shallow: true
  end
  resources :friendings, only: [ :create, :destroy ]
  get "login" => "sessions#new"
  post 'login' => 'sessions#create'
  delete "logout" => "sessions#destroy"
end

# want to be able to say /morganmartin/timeline and
# it give me morgan martin's timeline
# want to be able to visit that route as morgan and create
# a new post.
