class UsersBackoffice::DashboardController < UsersBackofficeController

  def index
    params[:q] ||= { user_profile_id_eq: current_user.user_profile.id, date_gteq: Date.today.beginning_of_month, date_lteq: Date.today.end_of_month }

    @q = Transaction.ransack(params[:q])

    @transactions = @q.result(distinct: true).includes(:account, :category)

    @accounts = Account.group(:title).sum(:price_cents)
  end

  def create_transaction
    @transaction = Transaction.new(transaction_params)
    @transaction.user_profile = current_user.user_profile

    respond_to do |format|
      if @transaction.save!
        format.html { redirect_to root_path, notice: "Transação criada com sucesso!" }
        format.json { render :index, status: :created, location: @transaction }
        format.js
      else
        format.html { redirect_to users_backoffice_dashboard_index_url, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_account
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to root_path, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_id, :category_id, :user_profile_id, :description, :price_cents, :date)
  end

  def account_params
    params.require(:account).permit(:title, :price_cents, :user_profile_id)
  end
end
