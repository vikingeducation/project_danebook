Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "static_pages#home"

  get '/timeline' => "static_pages#timeline"
  get '/friends' => "static_pages#friends"
  get '/about' => "static_pages#about"
  get '/photos' => "static_pages#photos"
  get '/about_edit' => "static_pages#about_edit"
end
