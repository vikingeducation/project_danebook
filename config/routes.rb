Rails.application.routes.draw do
  root 'static_pages#index'
  resources :static_pages, :only => [:index]

  get "/static_pages/timeline", to: "static_pages#timeline", as: "timeline"

  get "/static_pages/about", to: "static_pages#about", as: "about"

  get "/static_pages/about_edit", to: "static_pages#about_edit", as: "about_edit"

  get "/static_pages/friends", to: "static_pages#friends", as: "friends"

  get "/static_pages/photos", to: "static_pages#photos", as: "photos"
end
