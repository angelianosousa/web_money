# frozen_string_literal: true

# CreateTransaction
class CreateTransaction < ApplicationService
  def initialize(profile, params)
    super()
    @profile            = profile
    @account            = @profile.accounts.find(params.delete(:account_id))
    @category           = @profile.categories.find(params.delete(:category_id)) if params[:category_id].present?
    @budget             = @profile.budgets.find(params.delete(:budget_id)) if params[:budget_id].present?
    @transaction        = @account.transactions.build
    @transaction_params = params
  end

  def call
    valid_transaction if @transaction.expense? 

    transaction_payment_create
    
    @transaction
  end

  private

  def invalid_excharge
    @account.price_cents > @transaction_params[:price_cents].to_f
  end

  def valid_transaction
    return if invalid_excharge

    @transaction.errors.add :base, :invalid,
                            message: "Conta #{@account.title} não possui saldo suficiente."
  end

  def move_are_transfer?
    @transaction_params[:move_type] == 'transfer'
  end

  def transaction_payment_create
    Transaction.transaction do
      @transaction.user_profile = @profile
      @transaction.category     = @category
      @transaction.description  = move_are_transfer? ? 'Transferência entre contas' : @transaction_params[:description]
      @transaction.price_cents  = @transaction_params[:price_cents].to_f
      @transaction.move_type    = @transaction_params[:move_type]
      @transaction.budget       = @budget if @budget.present?
      @transaction.date         = Date.today.to_datetime
    end
  end
end
