Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  root to: 'pages#index'
  get '*path', to: 'pages#index'
  
  # Routerのmodeがhashの場合は不要です
  # get '/article/:id', to: 'pages#index'
end