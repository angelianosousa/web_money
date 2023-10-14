# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users

  resources :bills, except: [:new] do
    post 'new_transaction'
  end
  
  resources :accounts, except: %i[show new] do
    post :transfer_between_accounts, on: :collection
  end
  
  resources :dashboard, only: :index
  resources :user_profile,  only: %i[edit update destroy]
  resources :transactions,  except: %i[show new]
  resources :budgets,       except: %i[show new]
  resources :notifications, only: [:index]
  resources :categories,    except: [:show]
  patch '/notifications/mark_as_read/:id', to: 'notifications#mark_as_read'

  root to: 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
