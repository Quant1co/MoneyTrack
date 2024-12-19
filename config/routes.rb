Rails.application.routes.draw do
  root 'home#index', as:'home'
  root to: 'home#index'
  get 'register', to: 'users#new', as: 'register'
  post 'users', to: 'users#create', as: 'users'

  get 'logined', to: 'logined#index', as: 'logined'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
