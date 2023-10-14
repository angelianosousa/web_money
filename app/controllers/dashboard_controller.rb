# frozen_string_literal: true

# Dashboard Routes Controller
class DashboardController < ApplicationController
  def index
    set_default_search_params
    perform_search

    @categories      = @transactions.includes(:category).group(:title).sum(:price_cents)
    @bills           = @transactions.where.not(bill_id: nil).includes(:bill).group(:title).sum(:price_cents)
    @current_balance = @transactions.recipes.sum(:price_cents) - @transactions.expenses.sum(:price_cents)
  end

  private

  def set_default_search_params
    params[:q] ||= { user_profile_id_eq: current_profile.id, date_gteq: Date.today.beginning_of_month,
                     date_lteq: Date.today.end_of_month }
  end

  def perform_search
    @q = current_profile.transactions.ransack(params[:q])
    @transactions = @q.result(distinct: true)
  end
end
