Rails.application.routes.draw do
  default_url_options host: ENV['APP_URL']

  scope defaults: { format: :json } do
    root to: 'home#index'
    post 'signup' => 'users#create'
    post 'login' => 'user_token#create'
    resource :password, only: %i(create update)

    resources :tickets, only: %i(index show create destroy) do
      collection do
        post :search, to: 'tickets#index'
      end
      member do
        post :reply
        put :reopen
        put :close
      end
    end

    resources :users, only: %i(index destroy) do
      collection do
        post :search, to: 'users#index'
      end
    end

    resource :report, only: %i(show)

    get '*unmatched_route', to: 'application#route_not_found'
  end
end
