Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  get '/profile', to: 'user#index'
  match '/login', to: 'user#login', via: [:get, :post]
  get '/logout', to: 'user#logout'
  get '/login/liu_id', to: 'user#login_liu_id'
  get '/login/verify', to: 'user#verify_liu_id'

  get 'index' => 'pages#index'
  get 'info' => 'pages#info'
  get 'contacts' => 'pages#contacts'

  # Let’s encrypt
  get '/.well-known/acme-challenge/:id' => 'lets_encrypt#challenge', as: :letsencrypt_challenge
end
