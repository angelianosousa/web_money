class UsersBackoffice::TransactionsController < UsersBackofficeController
  before_action :set_transaction, only: %i[ edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    params[:q] ||= { user_profile_id_eq: current_user.user_profile.id }

    @q = Transaction.ransack(params[:q])
    @transactions = @q.result.page(params[:page])

    @balance = Account.sum(:price_cents)

    @transactions = Transaction.default(params[:page], 15, @transactions)
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_profile = current_user.user_profile

    respond_to do |format|
      if @transaction.save!
        format.html { redirect_to users_backoffice_transactions_path, notice: "Transação criada com sucesso!" }
        format.json { render :index, status: :created, location: @transaction }
      else
        format.html { redirect_to users_backoffice_transactions_url, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    @transaction.user_profile_id = current_user.user_profile.id
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to users_backoffice_transactions_path, notice: "Transação atualizada com sucesso!" }
        format.json { render json: @transaction, status: :ok, location: @transaction }
      else
        format.html { render :edit, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.account.price_cents -= @transaction.price_cents if @transaction.category.transaction_type == 'recipe'
    @transaction.account.price_cents += @transaction.price_cents if @transaction.category.transaction_type == 'expense'
    @transaction.account.save
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to users_backoffice_transactions_url, notice: "Transação apagada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:account_id, :category_id, :user_profile_id, :description, :price_cents, :date)
    end
end
