Rails.application.routes.draw do


  root "users#new"

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  resources :users, :only => [:new, :create, :show, :edit, :update] do
    resource :profile, :only => [:new]
    resources :posts, :only => [:create, :index, :destroy]
    resources :friends, :only => [:create, :index, :destroy]
    resources :photos, :only => [:new, :create, :index, :show, :destroy] do
      resource :profile_photo, :only => [:update]
      resource :cover_photo, :only => [:update]
    end
    resource :newsfeed, :only => [:show, :update]
  end

  resources :comments, :only => [:create, :destroy]
  resources :likes, :only => [:create, :destroy]

  resources :profiles, :only => [:index]
  get 'search' => 'profiles#index'


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
