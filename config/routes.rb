Rails.application.routes.draw do
  root to: 'pages#index'

  constraints format: :json do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'auth/registrations'
    }

    scope :api do
      resources :posts, only: [:index, :show]
    end
  end

  resources :posts, only: [:create, :update, :destroy]
  # Routerのmodeがhashの場合は不要です
  # get '/article/:id', to: 'pages#index'
  get '*path', to: 'pages#index'
end