Rails.application.routes.draw do
  root 'static_pages#home'
  get '/timeline' => 'static_pages1#timeline'
  get '/friends' => 'static_pages1#friends'
  get '/photos' => 'static_pages1#photos'
  get '/about' => 'static_pages1#about'
  get '/about_edit' => 'static_pages1#about_edit'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
