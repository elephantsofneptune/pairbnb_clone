Rails.application.routes.draw do

  resources :listing_attachments
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :index, :show, :edit, :update] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  end

  resources :listings, only: [:index, :show, :edit, :update, :new, :create, :destroy] do
    resources :reservations, only: [:create]

    collection do
      # get :recent
      # get :country
      get :approved
      get :search
      get :pending
      get :denied
    end

  end

  resources :reservations, only: [:index, :show] do
    resources :payments, only: [:new,:create]
  end

  resources :payments, only: [:show]

  root 'static#index'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth", as: "omni_auth"

  get 'braintree/new'
  post 'braintree/checkout'

end
