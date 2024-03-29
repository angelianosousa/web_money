Rails.application.routes.draw do
  
  resources :budgets
  devise_for :users

  resources :dashboard, only: :index do
    collection do
      post 'create_transaction'
      post 'create_account'
      post 'create_bill'
    end
  end
  
  resources :bills, except: [:new] do
    post 'new_transaction'
  end

  resources :accounts, except: [:show, :new] do
    post :transfer_between_accounts, on: :collection
  end

  resources :user_profile, only: %i[edit update destroy]
  resources :transactions, except: [:show, :new]
  resources :notifications, only: [:index]
  resources :categories, except: [:show]
  patch '/notifications/mark_as_read/:id', to: "notifications#mark_as_read" 

  root to: "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
