class TransferBetweenAccounts < ApplicationService
  # 1. Achar contas
  # 2. Validar se a conta tem dinheiro suficiente para transação
  # 3. Realizar transação caso seja possível

  def initialize(profile, params)
    @profile         = profile
    @params          = params
    
    
  end

  def call
    return false if accounts_equals? or invalid_excharge

    ActiveRecord::Base.transaction do
      create_excharge
      create_deposit
    end

    true
  end

  def create_excharge
    CreateTransaction.call(@profile, transaction_params.merge!({ category_id: category_expense(), account_id: @params[:account_id_out] }))
  end

  def create_deposit
    CreateTransaction.call(@profile, transaction_params.merge!({ category_id: category_recipe(), account_id: @params[:account_id_in] }))
  end

  private

  def accounts_equals?
    @params[:account_id_in] == @params[:account_id_out]
  end

  def invalid_excharge
    account_out.price_cents < @params[:price_cents].to_f
  end

  def account_out
    @profile.accounts.find(@params[:account_id_out])
  end

  def category_recipe
    @profile.categories.find_by(title: 'Transferência entrada').id
  end

  def category_expense
    @profile.categories.find_by(title: 'Transferência saída').id
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
