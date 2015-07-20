Rails.application.routes.draw do
  
  root to: 'staticpages#home'
  get '/' => 'staticpages#home'

  
  # resources :staticpages

  

  
end
