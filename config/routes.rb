Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  # Pages
  get 'index' => 'pages#index'
  get 'info' => 'pages#info'


  # Controller
  get 'contact' => 'contacts#contact'
  get 'press' => 'contacts#press'


  # Let’s encrypt
  get '/.well-known/acme-challenge/:id' => 'lets_encrypt#challenge', as: :letsencrypt_challenge

  # Static controller
  get '/:category/*page' => 'pages#index'


end
