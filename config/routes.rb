Rails.application.routes.draw do
  get 'search', to: 'search#index' 
  get 'portfolio', to: 'pages#portfolio'
 

  root 'pages#home'

  # resources :stocks_traders
  resources :stocks
  devise_for :traders
  resources :traders 
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
