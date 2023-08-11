Rails.application.routes.draw do
  #.........................USER......................................
  post 'users/login'
  get '/login', to: 'users#signin'
  get '/show/:id', to: 'users#show'
  resources :users
  resources :sell_products
end
