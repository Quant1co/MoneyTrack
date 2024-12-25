Rails.application.routes.draw do
  get "transactions/create"
  get "accounts/index"
  get "accounts/new"
  get "accounts/create"
  get "main_accounts/account"
  root 'home#index', as:'home'
  root to: 'home#index'
  get 'register', to: 'users#new', as: 'register'
  post 'users', to: 'users#create', as: 'users'

  get 'logined', to: 'logined#index', as: 'logined'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :accounts, only: [:index, :new, :create]
  resources :transactions, only: [:create]

  get 'account', to: 'accounts#index'  # Путь к основному счету




end
