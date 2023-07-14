class TransferBetweenAccounts < ApplicationService
  # 1. Achar contas
  # 2. Validar se a conta tem dinheiro suficiente para transação
  # 3. Realizar transação caso seja possível

  def initialize(profile, params)
    @profile         = profile
    @params          = params
    @category_id_in  = @profile.categories.find_by(title: 'Transferência entrada').id
    @category_id_out = @profile.categories.find_by(title: 'Transferência saída').id
    @transaction_in  = nil
    @transaction_out = nil
  end

  def call
    ActiveRecord::Base.transaction do
      create_excharge
      create_deposit

      return false if accounts_equals? or @transaction_out.nil? or invalid_excharge

      @transaction_out.save
      @transaction_in.save
    end

    true
  end

  def create_excharge
    @transaction_out = CreateTransaction.call(@profile, transaction_params.merge!({ category_id: @category_id_out, account_id: @params[:account_id_out] }))
  end

  def create_deposit
    @transaction_in = CreateTransaction.call(@profile, transaction_params.merge!({ category_id: @category_id_in, account_id: @params[:account_id_in] }))
  end

  private

  def accounts_equals?
    @params[:account_id_in] == @params[:account_id_out]
  end

  def invalid_excharge
    @transaction_out.account.price_cents < @transaction_out.price_cents
  end

  def transaction_params
    {
      user_profile: @profile,
      price_cents: @params[:price_cents].to_f,
      description: 'Transferência entre contas',
      date: Date.today.to_datetime
    }
  end
end
