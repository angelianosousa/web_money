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
  resources :users,  only: %i[edit update destroy]
  resources :transactions,  except: %i[show new]
  resources :budgets,       except: %i[show new]
  resources :categories,    except: [:show]
  
  resources :notifications, only: [:index] do
    patch :mark_as_read, on: :member
  end

  root to: 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
