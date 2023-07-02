class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    params[:q] ||= { user_profile_id_eq: current_profile.id }

    @q = current_profile.transactions.ransack(params[:q])
    @transactions = @q.result.page(params[:page]).order(date: :desc)

    @balance = current_profile.accounts.sum(:price_cents)

    @transactions = current_profile.transactions.default(params[:page], 10, @transactions)
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_profile.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to transactions_path, flash: { notice: t('.notice') } }
        format.json { render :index, status: :created, location: @transaction }
        format.js
      else
        format.html { redirect_to transactions_url, flash: { alert: @transaction.errors.full_messages } }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    @transaction.user_profile_id = current_user.user_profile.id
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transactions_path, flash: { notice: t('.notice') } }
        format.json { render json: @transaction, status: :ok, location: @transaction }
      else
        format.html { render :edit, flash: { alert: @transaction.errors.full_messages } }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.account.price_cents -= @transaction.price_cents if @transaction.category.category_type == 'recipe'
    @transaction.account.price_cents += @transaction.price_cents if @transaction.category.category_type == 'expense'
    @transaction.account.save
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to transactions_url, flash: { notice: t('.notice') } }
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
      params.require(:transaction).permit(:account_id, :category_id, :user_profile_id, :description, :price_cents, :date)
    end
end
