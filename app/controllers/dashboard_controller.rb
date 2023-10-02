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

  def create_transaction
    @transaction = current_profile.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        handle_successful_creation(format, root_path, { success: [t('.success')] }, @transaction)
      else
        handle_failed_creation(format, dashboard_index_url, @transaction)
      end
    end
  end

  def create_account
    @account = current_profile.accounts.build(account_params)

    respond_to do |format|
      if @account.save
        handle_successful_creation(
          format, root_path, { success: [t('.success')] }, @account
        )
      else
        handle_failed_creation(format, root_path, @account)
      end
    end
  end

  def create_bill
    @bill = current_profile.bills.build(bill_params)
    respond_to do |format|
      if @bill.save
        handle_successful_creation(format, root_path, { success: [t('.success')] }, @bill)
      else
        handle_failed_creation(format, root_path, @bill)
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_id, :category_id, :user_profile_id, :description, :price_cents, :date)
  end

  def account_params
    params.require(:account).permit(:title, :price_cents, :user_profile_id)
  end

  def bill_params
    params.require(:bill).permit(:title, :price_cents, :due_pay, :bill_type, :status)
  end

  def set_default_search_params
    params[:q] ||= { user_profile_id_eq: current_profile.id, date_gteq: Date.today.beginning_of_month,
                     date_lteq: Date.today.end_of_month }
  end

  def perform_search
    @q = current_profile.transactions.ransack(params[:q])
    @transactions = @q.result(distinct: true)
  end
end
