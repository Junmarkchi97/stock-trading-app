Rails.application.routes.draw do
  # resources :transactions
  # get 'buy', to: 'transactions#new'
  # post 'buy', to: 'transaction#new'
  get 'search', to: 'search#index' 
  get 'portfolio', to: 'dashboard#portfolio'
 
# <<<<<<< HEAD
#   get 'portfolio', to: 'pages#portfolio'
 

#   root 'pages#home'
# =======
  
  root 'dashboard#index'

  
  resources :stocks_traders
  resources :stocks do
    get 'buy', to: 'transactions#new'
    post 'buy', to: 'transactions#new'
    resources :transactions
  end
  devise_for :traders
  resources :traders 
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
