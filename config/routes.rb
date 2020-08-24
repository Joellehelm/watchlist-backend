Rails.application.routes.draw do
  resources :shows
  resources :episodes
  resources :seasons
  resources :progresses
  resources :user_shows

  resources :users

  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
  get '/auto_login', to: 'auth#auto_login'
  get '/watchlist', to: 'users#watchlist'
  post '/get_progress', to: 'progresses#get_progress'
  post 'show_in_watchlist', to: 'users#show_in_watchlist'
  patch 'update_password', to: 'users#update_password'
  
  
end
