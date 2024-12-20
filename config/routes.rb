Rails.application.routes.draw do
  root 'home#index', as:'home'
  get 'register', to: 'users#new', as: 'register'
  post 'users', to: 'users#create', as: 'users'

  get 'logined', to: 'logined#index', as: 'logined'
  post 'logined', to: 'logined#create'
  delete 'logined', to: 'logined#destroy'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'

  get 'logout', to: 'sessions#destroy', as: 'logout'

  resource :saving, only: [:show, :update] do
    post 'deposit', on: :member
    post 'withdraw', on: :member
  end

end


