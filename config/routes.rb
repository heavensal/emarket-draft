Rails.application.routes.draw do
  get "pages/home"
  get "pages/about"
  get "pages/contact"
  get "pages/faq"
  get "pages/privacy_policy"
  get "pages/legal_notice"
  get "pages/terms_and_conditions"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  root "collections#index"

  # users
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # collections
  resources :collections

  # categories
  resources :categories

  # products
  resources :products do
    resources :cart_items, only: [ :create ]
  end

  # carts
  resources :carts do
    resources :cart_items, only: [ :destroy ]
  end

  get "cart/:id/checkout" => "carts#checkout", as: :cart_checkout
  get "cart/success" => "carts#success", as: :cart_success
  get "cart/cancel" => "carts#cancel", as: :cart_cancel

  namespace :admin do
    resources :users
    resources :collections
    resources :categories
    resources :products
    resources :carts
    resources :cart_items
  end

end
