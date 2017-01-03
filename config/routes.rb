Rails.application.routes.draw do


  resources :listing_attachments
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :index, :show, :edit, :update] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  end

  resources :listings, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
    resources :reservations, only: [:create]
  end
  
  resources :reservations, only: [:index, :show]

  root 'static#index'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth", as: "omni_auth"
 
  get 'braintree/new'
  post 'braintree/checkout'
  
  # get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  # delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  # get "/sign_up" => "clearance/users#new", as: "sign_up"

  # get 'static/index'

  # get 'listings/create'

  # get 'listings/index'

  # get 'listings/show'

  # get 'listings/new'

  # get 'users/index'

  # get 'users/show'

  # get 'users/new'

  # get 'users/create'

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
