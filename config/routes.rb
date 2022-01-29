Rails.application.routes.draw do

  devise_for :users
  
  namespace :users_backoffice do
    get 'welcome/index'
    resources :recurrences, except: [:show]
    resources :transactions, except: [:show]
  end

  root to: "users_backoffice/welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
