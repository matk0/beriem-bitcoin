Rails.application.routes.draw do
  # Devise authentication
  devise_for :admins, path: "admin", path_names: {
    sign_in: "login",
    sign_out: "logout"
  }

  # Public pages
  root "pages#home"
  get "bitcoin", to: "pages#bitcoin"
  get "faq", to: "pages#faq"
  get "navody", to: "pages#navody"
  get "navody/:slug", to: "pages#navod", as: :navod

  # Expert directory
  resources :experts, only: [ :index, :show ] do
    resources :contact_submissions, only: [ :new, :create ]
  end

  # General contact form
  resources :contact_submissions, only: [ :create ]

  # Admin namespace
  namespace :admin do
    root "dashboard#index"
    resources :experts
    resources :contact_submissions, only: [ :index, :show, :update ]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
