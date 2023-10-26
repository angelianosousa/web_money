# frozen_string_literal: true

# Dashboard Routes Controller
class DashboardController < ApplicationController
  def index
    set_default_search_params
    perform_search

    @categories      = current_profile.categories.includes(:transactions)
    @bills           = current_profile.bills.includes(:transactions)
    @current_balance = @transactions.recipes.sum(:price_cents) - @transactions.expenses.sum(:price_cents)
  end

  private

  def set_default_search_params
    params[:q] ||= { user_profile_id_eq: current_profile.id }
  end

  def perform_search
    @q = current_profile.transactions.ransack(params[:q])
    @transactions = @q.result(distinct: true)
  end
end
