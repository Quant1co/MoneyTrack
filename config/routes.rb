Rails.application.routes.draw do
  get "main_accounts/account"
  root 'home#index', as:'home'
  root to: 'home#index'
  get 'register', to: 'users#new', as: 'register'
  post 'users', to: 'users#create', as: 'users'

  get 'logined', to: 'logined#index', as: 'logined'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'



  get 'main_account/account', to: 'main_accounts#account', as: 'account'


  resources :main_accounts do
    member do
      post 'create_expense_income'  # Создание операции
    end
  end











end
