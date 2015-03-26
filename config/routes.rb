Rails.application.routes.draw do

  root 'welcome#index'

  resources :products

  get 'welcome/index'



end
