Rails.application.routes.draw do
  root 'users#newsfeed'

  resource :session, :only => [:new, :create, :destroy]
  get "/login" => "sessions#new"
  get "/logout" => "sessions#destroy"
  delete "/logout" => "sessions#destroy"
  get "/login" => "users#new"

  resources :users, only: [:index, :show, :create, :update] do
    resource :profile, only: [:show]
    resources :photos, only: [:new, :index, :edit, :show]
    resources :friendings, only: [:index]
    get 'newsfeed' => "users#newsfeed"
  end

  resource :profile, only: [:edit, :update]

  resources :photos, only: [:create, :update, :destroy] do
    resources :likes, only: [:create], :defaults => { :likeable => 'Photo'}
    resources :comments, only: [:new, :create]
  end

  resources :posts, only: [:create, :update, :destroy] do
    resources :likes, only: [:create], :defaults => { :likeable => 'Post'}
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:create, :destroy] do
    resources :likes, only: [:create], :defaults => { :likeable => 'Comment'}
  end

  resources :likes, only: [:destroy]

  resources :friendings, :only => [:create, :destroy]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
