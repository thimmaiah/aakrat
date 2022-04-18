Rails.application.routes.draw do
  resources :phases
  resources :projects
  namespace :admin do
    resources :users
    resources :companies
    resources :roles

    root to: "users#index"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    confirmations: 'users/confirmations'
  }

  resources :companies do
    get 'search', on: :collection
    get 'investor_companies', on: :collection
    get 'dashboard', on: :collection
    get 'investor_view', on: :member
  end

  resources :users do
    get 'search', on: :collection
    get 'welcome', on: :collection
    post 'reset_password', on: :collection
    post 'accept_terms', on: :collection
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "companies#dashboard"

  require 'sidekiq/web'
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
end
