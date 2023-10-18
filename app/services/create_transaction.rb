# frozen_string_literal: true

# CreateTransaction
class CreateTransaction < ApplicationService
  def initialize(user_profile, params)
    super()
    @user_profile       = user_profile
    @transaction_params = params
    @account            = @user_profile.accounts.find(@transaction_params[:account_id]) rescue nil
  end

  def call
    valid_transaction if transaction_are_expense
    
    @transaction_params.merge!(description: 'Transferência entre contas') if transaction_are_transfer?
    @transaction = @account.transactions.build(@transaction_params)
    
    @transaction
  end

  private

  def invalid_excharge
    @account.price_cents > @transaction_params[:price_cents].to_f
  end

  def valid_transaction
    return if invalid_excharge

    @transaction.errors.add :base, :invalid, message: "Conta #{@account.title} não possui saldo suficiente."
  end

  def transaction_are_expense
    @transaction_params[:move_type] == 'expense'
  end

  def transaction_are_transfer?
    @transaction_params[:move_type] == 'transfer'
  end

  # def transaction_payment_create
  #   Transaction.transaction do
  #     @transaction.user_user_profile = @profile
  #     @transaction.category     = @category
  #     @transaction.description  = move_are_transfer? ? 'Transferência entre contas' : @transaction_params[:description]
  #     @transaction.price_cents  = @transaction_params[:price_cents].to_f
  #     @transaction.move_type    = @transaction_params[:move_type]
  #     @transaction.budget       = @budget if @budget.present?
  #     @transaction.date         = Date.today.to_datetime
  #   end
  # end

  # def transaction_params
  #   {
  #     user_profile_id: @profile.id,
  #     category_id: @category&.id,
  #     price_cents:,
  #     move_type: @transaction_params[:move_type],
  #     budget: @budget&.id,
  #     date: DateTime.now
  #   }
  # end
end
