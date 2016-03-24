Rails.application.routes.draw do
  devise_for :users
  resources :listings do
    resources :orders
  end
  get 'pages/about'

  get 'pages/contact'
  get 'seller' => 'listings#seller'
  get 'sellers_sales' => 'orders#sellers_sales'
  get 'buyers_purchases' => 'orders#buyers_purchases'

  root 'listings#index'
end
