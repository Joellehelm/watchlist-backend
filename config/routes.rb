Rails.application.routes.draw do
  resources :shows
  resources :episodes
  resources :seasons
  resources :progresses
  resources :user_shows

  resources :users, only: [:create, :update]
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
  get '/auto_login', to: 'auth#auto_login'
  
  
end
