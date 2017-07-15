Rails.application.routes.draw do
  root 'static_pages#index'
  resources :static_pages, :only => [:index]

  get "/static_pages/timeline", to: "static_pages#timeline", as: "timeline"
end
