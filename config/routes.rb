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
  post 'logined', to: 'logined#create'
  delete 'logined', to: 'logined#destroy'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'stocks/data', to: 'stocks#data', as: 'stocks_data'

  resource :saving, only: [:show, :update] do
    post 'deposit', on: :member
    post 'withdraw', on: :member
  end

  resources :accounts, only: [:index, :new, :create]
  resources :transactions, only: [:create]

  get 'account', to: 'accounts#index'  # Путь к основному счету




end
