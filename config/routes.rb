Rails.application.routes.draw do

  unauthenticated :trader do
    root to: 'homepage#index', as: :unauthenticated_root
  end

  authenticated :trader do
    root to: 'dashboard#index', as: :authenticated_root
    get '/homepage' => 'homepage#index', as: :homepage
  end

  devise_scope :trader do
    root to: 'devise/sessions#new'
  end

  resources :transactions
  get 'buy', to: 'transactions#new'
  post 'buy', to: 'transactions#new'

  get 'search', to: 'search#index' 
  get 'portfolio', to: 'dashboard#portfolio'
  get 'pending', to: 'dashboard#pending'
 
# <<<<<<< HEAD
#   get 'portfolio', to: 'pages#portfolio'
 

#   root 'pages#home'
# =======
  
  
  resources :transactions
  resources :stocks_traders
  resources :stocks do
    # get 'buy', to: 'transactions#new'
    # post 'buy', to: 'transactions#new'
    # resources :transactions
  end
  devise_for :traders
  resources :traders 
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
