Rails.application.routes.draw do

  root 'posts#index'

  resources(:users, only: [:index, :show, :new, :create]) do
    resource :profile, only: [:show, :edit, :update]
    resources :friends, only: [:index]
    resources :photos, only: [:index]
  end

  resources :friends, only: [:create, :destroy]

  resources(:photos, only: [:show, :new, :create, :destroy]) do
    resources :likes, only: [:create, :destroy], :defaults => { likable: 'Photo' }
    resources(:comments, only: [:create, :destroy], :defaults => { commentable: 'Photo' }) do
      resources :likes, only: [:create, :destroy], :defaults => { likable: 'Comment' }
    end
  end

  resources(:posts, only: [:create, :destroy, :show]) do
    resources :likes, only: [:create, :destroy], :defaults => { likable: 'Post' }
    resources(:comments, only: [:create, :destroy], :defaults => { commentable: 'Post' }) do
      resources :likes, only: [:create, :destroy], :defaults => { likable: 'Comment' }
    end
  end
  resource  :session, only: [:create, :destroy]

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
