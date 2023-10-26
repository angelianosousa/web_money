# frozen_string_literal: true

# CreateTransaction
class CreateTransaction < ApplicationService
  def initialize(user_profile, params)
    super()
    @user_profile       = user_profile
    @transaction_params = params
  end

  def call
    @account     = find_account
    @transaction = @account.transactions.build(transaction_params)
    @transaction
  end

  private

  def find_account
    @user_profile.accounts.find(@transaction_params[:account_id])
  end

  def transaction_params
    {
      price_cents: @transaction_params[:price_cents],
      date: DateTime.now,
      account_id: @account.id,
      user_profile_id: @user_profile.id,
      category_id: @transaction_params[:category_id],
      bill_id: @transaction_params[:bill_id],
      budget_id: @transaction_params[:budget_id],
      move_type: @transaction_params[:move_type]
    }
  end
end
