# frozen_string_literal: true

# Dashboard Routes Controller
class DashboardController < ApplicationController
  def index
    set_default_search_params
    perform_search

    @categories      = current_user.categories.includes(:transactions)
    @bills           = current_user.bills.includes(:transactions)
    @current_balance = @transactions.recipes.sum(:price_cents) - @transactions.expenses.sum(:price_cents)
  end

  private

  def set_default_search_params
    params[:q] ||= { user_id_eq: current_user.id }
  end

  def perform_search
    @q = current_user.transactions.ransack(params[:q])
    @transactions = @q.result(distinct: true)
  end
end
