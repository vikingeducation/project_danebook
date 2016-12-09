Rails.application.routes.draw do
  root "users#new"
  resources :users do
    resources :profiles, :only => [:show, :edit]
  end
  resource :session, :only => [:create, :destroy]
  post "login" => "session#create"
  delete "logout" => "session#destroy"
end
