class CreateTransaction < ApplicationService
  def initialize(profile, params)
    @profile            = profile
    @category           = @profile.categories.find(params.delete(:category_id))
    @account            = @profile.accounts.find(params.delete(:account_id))
    @transaction        = @account.transactions.build
    @transaction_params = params
  end

  def call
    return nil if invalid_excharge

    Transaction.transaction do
      @transaction.user_profile = @profile
      @transaction.description  = @transaction_params[:description]
      @transaction.price_cents  = @transaction_params[:price_cents].to_f
      @transaction.category     = @category
      @transaction.date         = Date.today.to_datetime
    end

    return @transaction
  end

  private

  def invalid_excharge
    @account.price_cents < @transaction_params[:price_cents].to_f
  end
end