Rails.application.routes.draw do

  resources :password_resets
  root to: 'sessions#new'

  get '/forgot_password', to: 'sessions#forgot_password', as: 'forgot_password'

  resources :sub_requests do 
    get '/details', to: 'sub_requests#details', as: 'details'
    post '/fill_sub', to: 'sub_requests#fill_sub', as: 'fill'
  end

  get '/check_email', to: 'players#check_email', as: 'check_email'
  resources :players do 
    get '/payment_info', to: 'players#payment_info', as: 'payment_info'
    post '/add_payment_info', to: 'players#add_payment_info', as: 'add_payment_info'
    get '/add_teams', to: 'players#new_teams', as: 'new_teams'
    post '/create_teams', to: 'players#create_teams', as: 'create_teams'
    delete '/destroy_team/:team_id', to: 'players#destroy_team', as: 'destroy_team'
    resources :feedbacks, only: [:new, :create]
  end
  
  resources :games
  resources :sessions, only: [:create, :destroy]

  resources :sports do 
    get '/leagues', to: 'sports#get_leagues', as: 'leagues'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
