# frozen_string_literal: true

# Accounts Entity Controller
class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]

  # GET /accounts or /accounts.json
  def index
    @accounts = current_profile.accounts.page(params[:page]).order(created_at: :desc)
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts or /accounts.json
  def create
    @account = current_profile.accounts.new(account_params)

    respond_to do |format|
      if @account.save
        handle_successful_creation(format, accounts_path, @account)
      else
        handle_failed_creation(format, accounts_path, @account)
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        handle_successful_update(format, accounts_url, @account)
      else
        handle_failed_update(format, nil, @account)
      end
    end
  end

  def new_transaction
    @transaction = CreateTransaction.call(current_profile, params)

    unless @transaction.errors.none?
      redirect_to accounts_url, flash: { success: t('.success') }
    else
      redirect_to accounts_url, flash: { danger: @transaction.errors.full_messages }
    end
  end

  def transfer_between_accounts
    @result = TransferBetweenAccounts.call(current_profile, params)

    if @result
      redirect_to accounts_path, flash: { success: t('.success') }
    else
      redirect_to accounts_path, flash: { danger: 'Saldo insuficiente para operação' }
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, flash: { success: t('.success') } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = current_profile.accounts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account).permit(:title, :price_cents, :user_profile_id)
  end
end
