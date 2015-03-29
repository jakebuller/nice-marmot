Rails.application.routes.draw do

  # Landing page setup
  root 'welcome#index'
  get 'welcome/index'

  # Product routes
  # resources :products
  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show'
end
