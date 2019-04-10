Rails.application.routes.draw do
  
  
  root 'main#index'
 
  get 'main/index'

  # User
  get '/signup', to:"users#new"
  post '/signup',to:"user#create"

  # Session
  get '/Login', to:"sessions#new"
  post '/login', to:'sessions#create'
  delete '/logout', to:"sessions#destroy"
 
  # Post
  resources :posts
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
