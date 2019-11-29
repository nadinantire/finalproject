require 'sidekiq/web'

Rails.application.routes.draw do
  resources :artifacts
  resources :categories
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 
  resources :exhibitions
  resources :garelleys
  resources :visits
  resources :exhibitions do
    resources :tickets
  end
  namespace :admin do
    resources :users
    resources :announcements
    resources :notifications
    resources :services

  

    root to: "users#index"
    get '/card/new' => 'transaction#new_card', as: :add_payment_method
    post "/card" => "transaction#create_card", as: :create_payment_method
    get '/success' => 'transaction#success', as: :success
    post '/subscription' => 'transaction#subscribe', as: :subscribe
  end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end


  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # , controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # root to: 'plaid#new'
  root 'transactions#index', as: :transaction 
  # get '/card/new' => 'transaction#new_card', as: :add_payment_method`
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :transaction
end
