# frozen_string_literal: true

# TransferBetweenAccounts
class TransferBetweenAccounts < ApplicationService
  # 1. Achar contas
  # 2. Validar se a conta tem dinheiro suficiente para transação
  # 3. Realizar transação caso seja possível

  def initialize(user, params)
    super()
    @user   = user
    @params = params
  end

  def call
    return @user if accounts_equals? || invalid_excharge
    # byebug
    ActiveRecord::Base.transaction do
      create_excharge
      create_deposit
    end

    @user
  end

  def create_excharge
    transaction = CreateTransaction.call(@user, transaction_params.merge!({ account_id: @params[:account_id_out] }))
    @account_out = account_out
    if transaction.save
      @account_out.price_cents -= transaction.price_cents
      @account_out.save
    end

    @account_out.errors.any?
  end

  def create_deposit
    transaction = CreateTransaction.call(@user, transaction_params.merge!({ account_id: @params[:account_id_in] }))
    @account_in = account_in
    if transaction.save
      @account_in.price_cents += transaction.price_cents
      @account_in.save
    end

    @account_in.errors.any?
  end

  private

  def accounts_equals?
    return false unless @params[:account_id_in] == @params[:account_id_out]

    message = I18n.t('accounts.transfer_between_accounts.errors.same_account')
    @user.errors.add :base, :transfer_invalid, message: message
  end

  def account_out
    @user.accounts.find(@params[:account_id_out])
  end

  def account_in
    @user.accounts.find(@params[:account_id_in])
  end

  def invalid_excharge
    # byebug
    return false unless account_out.price < Money.new(@params[:price])

    message = I18n.t('accounts.transfer_between_accounts.errors.insufficient_amount', account_title: account_out.title)
    @user.errors.add :base, :transfer_invalid, message: message
  end

  def transaction_params
    {
      price: @params[:price],
      description: @params[:description],
      move_type: :transfer,
      date: Date.today.to_datetime
    }
  end
end
