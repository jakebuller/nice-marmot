Rails.application.routes.draw do

  # Landing page setup
  root 'products#index'

  # Product routes
  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show'

  # Mailing address routes
  post 'mailing_addresses', to: 'mailing_addresses#add'

  # About routes
  get 'about', to: 'about#index'
end
