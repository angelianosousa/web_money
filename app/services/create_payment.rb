# frozen_string_literal: true

# CreatePayment
class CreatePayment < ApplicationService
  def initialize(user, bill, params)
    super()
    @params      = params
    @user        = user
    @bill        = bill
    @transaction = build_transaction
  end

  def call
    ActiveRecord::Base.transaction do
      return payment_without_bill unless @bill.present?

      @bill.update(due_pay: @bill.due_pay.next_month, status: :paid) if @transaction.save!
    rescue ActiveRecord::RecordInvalid => e
      p e.message
    end

    @bill
  end

  def build_transaction
    CreateTransaction.call(@user, transaction_params)
  end

  def transaction_params
    {
      account_id: @params[:account_id],
      category_id: @params[:category_id],
      price_cents: @params[:price_cents],
      description: @params[:description],
      move_type: @bill.bill_type,
      date: Date.today.to_datetime,
      bill_id: @bill.id
    }
  end

  def payment_without_bill
    @transaction.errors.add :base, :invalid, message: 'Transação sem id do pagamento recorrente'
  end
end
