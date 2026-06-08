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

    check_if_has_to_update_bill if @transaction.valid? && @params[:bill_id]

    @transaction
  end

  private

  def find_account
    @user.accounts.find(@params[:account_id])
  end

  def find_bill
    @user.bills.find(@params[:bill_id])
  end

  def check_if_has_to_update_bill
    return unless @params[:bill_id].present?

    @bill = check_if_bill_was_paid
    @bill.update(due_pay: @bill.due_pay.next_month, status: :paid)
  end

  def check_if_bill_was_paid
    @bill = find_bill

    return @bill if @bill.pending?

    message = I18n.t('activerecord.attributes.errors.models.invalid_bill_payment', bill_title: @transaction.bill.title)

    @transaction.errors.add :base, :invalid, message: message
  end

  def transaction_params
    {
      user_id: @user.id,
      account_id: @params[:account_id],
      category_id: @params[:category_id],
      bill_id: @params[:bill_id],
      budget_id: @params[:budget_id],
      price: @params[:price],
      date: @params[:date] || DateTime.now,
      move_type: @params[:move_type]
    }
  end
end
