Rails.application.routes.draw do
  #.........................USER......................................
  post 'users/login'
  get '/login', to: 'users#signin'
  resources :users
   #......................SELL_PRODUCT.................................
  resources :sell_products

  #.........................USER......................................
  post 'users/login'
  resources :users

  #.......................BUY_PRODUCT....................................
  get '/products', to: 'buy_products#show_available_products'
  get 'show/category', to: 'buy_products#show_data_category_wise'
  resources :buy_products

  #.......................CATEGORY....................................
  resources :categories
end
