# frozen_string_literal: true

# Transactions Entity Controller
class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[edit update destroy]

  # GET /transactions or /transactions.json
  def index
    set_default_search_params
    perform_search

    @balance = current_profile.accounts.sum(:price_cents)
    @transactions = Kaminari.paginate_array(@transactions.to_a).page(params[:page]).per(5)
  end

  # GET /transactions/1/edit
  def edit; end

  # POST /transactions or /transactions.json
  def create
    @transaction = CreateTransaction.call(current_profile, transaction_params)

    respond_to do |format|
      if @transaction.errors.none?
        handle_successful_creation(format, transactions_path, { success: t('.success') }, @transaction)
      else
        handle_failed_creation(format, transactions_url, @transaction)
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_path, flash: { success: t('.success') } }
        format.json { render json: @transaction, status: :ok, location: @transaction }
      else
        format.html { render :edit, flash: { danger: @transaction.errors.full_messages } }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.expense_or_recipe_calc
    @transaction.destroy
    @transaction.account.save

    respond_to do |format|
      format.html { redirect_to transactions_url, flash: { success: t('.success') } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = current_profile.transactions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:account_id, :category_id, :bill_id, :budget_id, :user_profile_id,
                                        :description, :price_cents, :date)
  end

  def set_default_search_params
    params[:q] ||= { user_profile_id_eq: current_profile.id }
  end

  def perform_search
    @q = current_profile.transactions.ransack(params[:q])
    @transactions = @q.result.order(created_at: :desc).group_by(&:date) # .page(params[:page]).per(5)
  end
end
