Rails.application.routes.draw do



  get 'profile_picture/create'

  get 'profile_picture/destroy'

  root "static_pages#home"

  resource :session, :only => [:create, :destroy, :new]

  resources :users, :only => [:create, :new, :edit, :update, :destroy] do 

    resource :profile, :only => [:update]  

    get '/friends', to: "static_pages#friends"
    get '/about', to: "static_pages#about"

    get '/about_edit', to: "static_pages#about_edit"

    resources :posts, :only => [:create, :update, :destroy, :index]
    get '/timeline', to: "posts#index"
    
    resources :friendships, :only => [:create, :destroy]

    resources :photos, :only => [:create, :new, :index, :show, :destroy] do 
      resources :cover_photo, :only => [:create, :destroy]
      resources :profile_picture, :only => [:create, :destroy]
    end


  end



  resources :posts, :only => [:show] do 
    resources :comments, :only => [:create, :destroy]
    resources :likes, :only => [:create, :destroy]
  end




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
