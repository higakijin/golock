Rails.application.routes.draw do
  root to: 'pages#index'

  constraints format: :json do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'auth/registrations'
    }

    resources :posts, only: [:index]
  end

  resources :posts, only: [:create]
  # Routerのmodeがhashの場合は不要です
  # get '/article/:id', to: 'pages#index'
  get '*path', to: 'pages#index'
end