# frozen_string_literal: true

# TransferBetweenAccounts
class TransferBetweenAccounts < ApplicationService
  # 1. Achar contas
  # 2. Validar se a conta tem dinheiro suficiente para transação
  # 3. Realizar transação caso seja possível

  def initialize(profile, params)
    super()
    @profile = profile
    @params  = params
  end

  def call
    return false if accounts_equals? || invalid_excharge

    ActiveRecord::Base.transaction do
      create_excharge
      create_deposit
    end

    true
  end

  def create_excharge
    transaction = CreateTransaction.call(@profile, transaction_params.merge!({ account_id: @params[:account_id_out] }))
    @account_out = account_out
    if transaction.save
      @account_out.price_cents -= transaction.price_cents
      @account_out.save
    end

    @account_out.errors.any?
  end

  def create_deposit
    transaction = CreateTransaction.call(@profile, transaction_params.merge!({ account_id: @params[:account_id_in] }))
    @account_in = account_in
    if transaction.save
      @account_in.price_cents += transaction.price_cents
      @account_in.save
    end

    @account_in.errors.any?
  end

  private

  def accounts_equals?
    @params[:account_id_in] == @params[:account_id_out]
  end

  def account_out
    @profile.accounts.find(@params[:account_id_out])
  end

  def account_in
    @profile.accounts.find(@params[:account_id_in])
  end

  def invalid_excharge
    account_out.price_cents < @params[:price_cents].to_f
  end

  def transaction_params
    {
      price_cents: @params[:price_cents],
      description: @params[:description],
      move_type: :transfer,
      date: Date.today.to_datetime
    }
  end
end
