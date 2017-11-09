Rails.application.routes.draw do

  root 'pages#home'

  get 'pages/home'
  get '/home' => 'pages#home', as: 'home'


  get 'pages/my_feed'
  get '/my_feed' => 'pages#my_feed', as: 'my_feed'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
