Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'

  get 'index' => 'pages#index'
  get 'info' => 'pages#info'
  get 'contacts' => 'pages#contacts#index'

end
