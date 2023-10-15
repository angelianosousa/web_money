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
    @account_out              = account_out
    @account_out.price_cents -= @params[:price_cents].to_f
    @account_out.save
  end

  def create_deposit
    @account_in              = @profile.accounts.find(@params[:account_id_in])
    @account_in.price_cents += @params[:price_cents].to_f
    @account_in.save
  end

  private

  def accounts_equals?
    @params[:account_id_in] == @params[:account_id_out]
  end

  def account_out
    @profile.accounts.find(@params[:account_id_out])
  end

  def invalid_excharge
    account_out.price_cents < @params[:price_cents].to_f
  end
end
