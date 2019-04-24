Rails.application.routes.draw do
  
  get 'sessions/new'
  root 'main#index'
 
  get 'main/index'
  get '/home', to: 'static_pages#home'

  # User
  get '/signup', to:"users#new"
  get '/profile',to:"users#show"
  post '/signup',to:"users#create"

  # Session
  get '/login', to:"sessions#new"
  post '/login', to:'sessions#create'
  delete '/logout', to:"sessions#destroy"
 
  # Post
  get '/post', to:"posts#show"
  resources :posts , only: [:index, :new, :create, :destroy,:show]
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
