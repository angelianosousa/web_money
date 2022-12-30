Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  
  # Sidekiq routes
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  
  devise_for :users
  
  namespace :users_backoffice do
    post 'dashboard/create_transaction'
    post 'dashboard/create_account'
    get 'dashboard/index'
    
    resources :bills, except: [:new] do
      post 'new_transaction'
    end

    resources :accounts, except: [:show, :new]
    resources :user_profile, only: %i[edit update destroy]
    resources :transactions, except: [:show, :new]
    resources :notifications, only: [:index]
    resources :categories, except: [:show]
    patch '/notifications/mark_as_read/:id', to: "notifications#mark_as_read" 
  end


  root to: "users_backoffice/dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
