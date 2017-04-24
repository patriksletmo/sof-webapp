Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'frontpage#index'

  # Internationalization
  get '/lang/:lang', to: 'application#change_language'

  # Authentication
  get '/profile', to: 'user#index', via: [:get, :post]
  match '/edit/password', to: 'user#edit_password', via: [:get, :post]
  match '/edit/name', to: 'user#edit_name', via: [:get, :post]
  match '/register', to: 'user#register', via: [:get, :post]
  match '/login', to: 'user#login', via: [:get, :post]
  match '/reset/request', to: 'user#request_password_reset', via: [:get, :post]
  match '/reset', to: 'user#reset_password', via: [:get, :post]
  get '/logout', to: 'user#logout'
  get '/login/liu_id', to: 'user#login_liu_id'
  get '/login/verify', to: 'user#verify_liu_id'
  match '/complete_profile', to: 'user#nag_display_name', via: [:get, :post]


  # Orchestra
  get 'orchestra' => 'orchestra#index'
  match 'orchestra/register' => 'orchestra#register', via: [:get, :post]
  match 'orchestra/create' => 'orchestra#create', via: [:get, :post]
  match 'orchestra/delete' => 'orchestra#delete', via: [:post]
  match 'orchestra/delete_orchestra' => 'orchestra#delete_orchestra', via: [:post]
  get 'orchestra/orchestras' => 'orchestra#orchestras'
  get 'orchestra/verify' => 'orchestra#verify_code'
  get 'orchestra/:id' => 'orchestra#show'
  post 'orchestra/:id' => 'orchestra#update'
  match 'orchestra/:id/reset_code' => 'orchestra#reset_code', via: [:post]
  get 'orchestra/signup/:id' => 'orchestra#show_signup'

  # Cortege
  get 'cortege' => 'cortege#index'
  get 'cortege/interest' => 'cortege#interest'
  post 'cortege/interest' => 'cortege#create'
  get 'cortege/:id' => 'cortege#show'
  post 'cortege/:id' => 'cortege#update'
  post 'cortege/:id/delete' => 'cortege#delete'
  post 'corteges/add_member/:id' => 'cortege#add_member'
  post 'corteges/remove_member/:id' => 'cortege#remove_member'

  # Case cortege
  get 'case_cortege' => 'case_cortege#index'
  get 'case_cortege/new' => 'case_cortege#new'
  post 'case_cortege/new' => 'case_cortege#create'
  get 'case_cortege/:id' => 'case_cortege#show'
  post 'case_cortege/:id' => 'case_cortege#update'
  post 'case_cortege/:id/delete' => 'case_cortege#delete'

  # Funkis
  get 'funkis' => 'funkis#index'
  get 'funkis/categories' => 'funkis#categories'
  match 'funkis/application' => 'funkis#application', via: [:get, :post]
  match 'funkis/application/shifts' => 'funkis#shift_selection', via: [:get, :post]
  match 'funkis/application/agreement' => 'funkis#agreement', via: [:get, :post]
  get 'funkis/application/complete' => 'funkis#show'

  # Festival
  get '/festivalen/servering/ol', to: 'festival#beer'

  # User management
  get 'manage/users' => 'user_management#index'
  get 'manage/users/:id' => 'user_management#show'
  post 'manage/users/:id' => 'user_management#update'
  post 'manage/users/:id/delete_funkis' => 'user_management#remove_funkis_application'

  # Orchestra management
  get 'manage/orchestras' => 'orchestra_management#index'
  get 'manage/orchestras/extra_performances' => 'orchestra_management#extra_performances'
  get 'manage/orchestras/anniversary' => 'orchestra_management#anniversary'
  get 'manage/orchestras/allergies' => 'orchestra_management#allergies'

  # Cortege management
  get 'manage/corteges' => 'cortege_management#index'
  get 'manage/corteges/:id' => 'cortege_management#show'
  post 'manage/corteges/:id' => 'cortege_management#update'
  post 'manage/corteges/add_member/:id' => 'cortege_management#add_member'
  post 'manage/corteges/remove_member/:id' => 'cortege_management#remove_member'

  # Case cortege management
  get 'manage/case_corteges' => 'case_cortege_management#index'
  get 'manage/case_corteges/:id' => 'case_cortege_management#show'
  post 'manage/case_corteges/:id' => 'case_cortege_management#update'

  # Webstore
  get 'store' => 'webstore#index'
  post 'store' => 'webstore#add_item_to_cart'
  get 'store/cart' => 'webstore#cart'
  post 'store/cart/clear' => 'webstore#clear_cart'
  post 'store/cart/delete/:id' => 'webstore#remove_item_from_cart'
  get 'store/checkout' => 'webstore#checkout'
  post 'store/checkout' => 'webstore#charge'

  # User inventory
  get 'store/orders' => 'user_inventory#orders'
  get 'store/orders/:id' => 'user_inventory#order'
  get 'store/inventory' => 'user_inventory#index'
  get 'store/inventory/:id' => 'user_inventory#order_item'
  post 'store/inventory/:id' => 'user_inventory#change_owner'

  # Product management
  get 'manage/products' => 'product_management#index'
  get 'manage/products/new' => 'product_management#new'
  post 'manage/products/new' => 'product_management#create'
  get 'manage/products/:id' => 'product_management#show'
  post 'manage/products/:id' => 'product_management#update'

  # Funkis management
  get 'manage/funkis' => 'funkis_management#index'
  get 'manage/funkis/all_funkis_applications' => 'funkis_management#all_funkis_applications'

  # Contact
  get 'contact/press' => 'contacts#press'
  get 'contact/funkis' => 'contacts#funkis'
  get 'contact/orchestra' => 'contacts#orchestra'
  get 'contact/cortege' => 'contacts#cortege'
  get 'contact/tickets' => 'contacts#tickets'
  get 'contact/it' => 'contacts#it'

  # Let’s encrypt
  get '/.well-known/acme-challenge/:id' => 'lets_encrypt#challenge', as: :letsencrypt_challenge

  # Pages controller
  get '/:category(/:page)' => 'pages#index'
end
