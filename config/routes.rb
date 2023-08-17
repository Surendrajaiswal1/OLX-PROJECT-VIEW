Rails.application.routes.draw do
  #.........................USER......................................
  post 'users/login'
  get '/login', to: 'users#signin'

  resource :users
   #......................SELL_PRODUCT.................................
  resources :sell_products

  #.......................BUY_PRODUCT....................................
  resources :buy_products   do
  get 'show_available_products', on: :collection
  get 'show_data_category_wise',on: :collection
  get 'buy', on: :member
   end
  #.......................CATEGORY....................................
  resources :categories
end
