class CreateTransaction < ApplicationService
  def initialize(profile, params)
    @profile            = profile
    @category           = @profile.categories.find(params.delete(:category_id))
    @account            = @profile.accounts.find(params.delete(:account_id))
    @transaction        = @account.transactions.build
    @transaction_params = params
  end

  def call
    valid_transaction if @category.expense?

    return @transaction unless @transaction.errors.none?

    Transaction.transaction do
      @transaction.user_profile = @profile
      @transaction.description  = @transaction_params[:description]
      @transaction.price_cents  = @transaction_params[:price_cents].to_f
      @transaction.category     = @category
      @transaction.date         = Date.today.to_datetime
      @transaction.save
    end

    return @transaction
  end

  private

  def validate_excharge
    @account.price_cents > @transaction_params[:price_cents].to_f
  end

  def valid_transaction
    @transaction.errors.add :base, :invalid, message: "Conta #{@account.title} não possui saldo suficiente." unless validate_excharge
  end
end