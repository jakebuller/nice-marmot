Rails.application.routes.draw do

  # Landing page setup
  root 'products#index'

  # Product routes
  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show'

  # Mailing address routes
  post 'mailing_addresses', to: 'mailing_addresses#add'

  #orders
  post 'orders', to: 'orders#create'

  # About routes
  get 'about', to: 'about#index'
end
