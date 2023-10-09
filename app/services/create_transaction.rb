# frozen_string_literal: true

# CreateTransaction
class CreateTransaction < ApplicationService
  def initialize(profile, params)
    super()
    @profile            = profile
    @category           = @profile.categories.find(params.delete(:category_id))
    @account            = @profile.accounts.find(params.delete(:account_id))
    @budget             = @profile.budgets.find(params.delete(:budget_id)) if params[:budget_id].present?
    @transaction        = @account.transactions.build
    @transaction_params = params
  end

  def call
    valid_transaction if @category.expense?
    return @transaction unless @transaction.errors.none?

    transaction_payment_create
    count_points_to_achieve if @transaction.save

    @transaction
  end

  private

  def validate_excharge
    @account.price_cents > @transaction_params[:price_cents].to_f
  end

  def valid_transaction
    return if validate_excharge

    @transaction.errors.add :base, :invalid,
                            message: "Conta #{@account.title} não possui saldo suficiente."
  end

  def transaction_payment_create
    Transaction.transaction do
      @transaction.user_profile = @profile
      @transaction.category     = @category
      @transaction.description  = @transaction_params[:description]
      @transaction.price_cents  = @transaction_params[:price_cents].to_f
      @transaction.budget       = @budget if @budget.present?
      @transaction.date         = Date.today.to_datetime
    end
  end

  def count_points_to_achieve
    CountAchievePoints.call(@profile, :money_movement)
    CountAchievePoints.call(@profile, :money_managed)
    CountAchievePoints.call(@profile, :budget_reached) if @budget.present?
  end
end
