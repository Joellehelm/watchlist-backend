Rails.application.routes.draw do
  resources :shows
  resources :episodes
  resources :seasons
  resources :progresses
  resources :user_shows

  resources :users, only: :create
  post '/login', to: 'auth#create'
  delete '/logout', to: 'auth#destroy'
  get '/logged_in', to: 'application#logged_in?'
end
