Rails.application.routes.draw do
  resources :steps do
    patch 'toggle_completed', on: :member
  end

  resources :notes

  resources :phases do
    patch 'toggle_completed', on: :member
  end

  resources :projects do
    patch 'clone_phases', on: :member
  end

  resources :payments

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
