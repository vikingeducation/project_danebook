Rails.application.routes.draw do
  root to: 'staticpages#home'
  get '/' => 'staticpages#home'
  # resources :staticpages
  get 'timeline' => 'staticpages#timeline'
  get 'friends' => 'staticpages#friends'
  get 'about' => 'staticpages#about'
  get 'photos' => 'staticpages#photos'
end
