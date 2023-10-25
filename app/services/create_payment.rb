# frozen_string_literal: true

# CreatePayment
class CreatePayment < ApplicationService
  def initialize(profile, bill, params)
    super()
    @params   = params
    @profile  = profile
    @bill     = bill
    @account  = @params.delete(:account_id)
    @category = @params.delete(:category_id)
  end

  def call
    ActiveRecord::Base.transaction do
      create_transaction

      @bill.paid!
      @bill.due_pay += Date.today.next_month.month
    rescue ActiveRecord::RecordInvalid => e
      p e.message
    end

    @bill
  end

  def create_transaction
    CreateTransaction.call(@profile, transaction_params)
  end

  def transaction_params
    {
      account_id: @account,
      category_id: @category,
      price_cents: @params[:price_cents],
      description: @params[:description],
      move_type: @bill.bill_type,
      date: Date.today.to_datetime,
      bill_id: @bill.id
    }
  end
end
