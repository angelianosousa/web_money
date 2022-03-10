Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  # Sidekiq routes
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  
  devise_for :users
  
  namespace :users_backoffice do
    get 'welcome/index'
    resources :recurrences, except: [:show, :new] do
      post 'payment'
    end

    resources :transactions, except: [:show, :new]
  end

  root to: "users_backoffice/welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
