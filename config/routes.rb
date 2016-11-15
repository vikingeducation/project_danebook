Rails.application.routes.draw do
  resources :users, :except => [:index] do
    resources :posts, :only => [:create, :destroy]
    resources :friendships, :only => [:index]
    resources :photos, :except => [:edit, :update]
    resource :activity, :only => [:show]
  end

  resources :comments, :only => [:create, :destroy]
  resources :likes, :only => [:create, :destroy]
  resources :friend_requests, :only => [:create, :update, :destroy]
  resources :friendships, :only => [:destroy]
  resources :activities, :only => [:index]

  resource :session, :only => [:create, :destroy]

  get '/search', :to => 'searches#index'
  get '/news_feed', :to => 'activities#index'
  get '/signup', :to => 'users#new'
  get '/login', :to => 'users#new'
  get '/logout', :to => 'sessions#destroy'

  root :to => 'activities#index'


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
