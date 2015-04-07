Rails.application.routes.draw do

  # Landing page setup
  root 'products#index'

  # Product routes
  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show'

  # About routes
  get 'about', to: 'about#index'
end
