Rails.application.routes.draw do
  resources :activities
  resources :users
  post '/login', to: 'sessions#create'
  post '/profile',  to: 'users#profile'
end
