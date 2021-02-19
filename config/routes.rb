Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get     '/about',         to: 'static_pages#about'
  get     '/help',          to: 'static_pages#help'
  get     '/signup',        to: 'users#new'
  post    '/signup',        to: 'users#create'
  get     '/login',         to: 'sessions#new'
  post    '/login',         to: 'sessions#create'
  delete  '/logout',        to: 'sessions#destroy'
  post    '/guest',         to: 'sessions#guest'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :diving_logs,         except: :index
  get     '/diving_logs',   to: 'diving_logs#new' #log作成失敗時にページをリロードするとno routeになってしまうのを防ぐ為
end
