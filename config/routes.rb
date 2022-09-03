Rails.application.routes.draw do
  get 'search', to: 'search#index' 
<<<<<<< HEAD
  get 'portfolio', to: 'pages#portfolio'
 

  root 'pages#home'
=======
  
  root 'dashboard#index'
>>>>>>> 47628bc884a613bc38acaef69b74983258c972e8

  # resources :stocks_traders
  resources :stocks
  devise_for :traders
  resources :traders 
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
