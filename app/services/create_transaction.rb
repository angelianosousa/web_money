# frozen_string_literal: true

# CreateTransaction
class CreateTransaction < ApplicationService
  def initialize(user, params)
    super()
    @user   = user
    @params = params
  end

  def call
    @transaction = @user.transactions.build(transaction_params)
    @transaction
  end

  private

  def find_account
    @user.accounts.find(@params[:account_id])
  end

  def transaction_params
    {
      user_id: @user.id,
      account_id: @params[:account_id],
      category_id: @params[:category_id],
      bill_id: @params[:bill_id],
      budget_id: @params[:budget_id],
      price_cents: @params[:price_cents],
      date: DateTime.now,
      move_type: @params[:move_type]
    }
  end
end
