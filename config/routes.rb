Rails.application.routes.draw do
  resources :shows
  resources :episodes
  resources :seasons
  resources :progresses
  resources :user_shows

  resources :users
  # , only: [:create, :update, :watchlist]
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
  get '/auto_login', to: 'auth#auto_login'
  get '/watchlist', to: 'users#watchlist'
  post '/get_progress', to: 'progresses#show'
  post '/show_by_imdbID', to: 'shows#show_by_imdbID'
  
end
