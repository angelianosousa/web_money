class DashboardController < ApplicationController

  def index
    params[:q] ||= { user_profile_id_eq: current_user.user_profile.id, date_gteq: Date.today.beginning_of_month, date_lteq: Date.today.end_of_month }

    @q = current_user_profile.transactions.ransack(params[:q])

    @transactions = @q.result(distinct: true)

    @categories = @transactions.includes(:category).group(:title).sum(:price_cents)
    @bills      = @transactions.where.not(bill_id: nil).includes(:bill).group(:title).sum(:price_cents)

    respond_to do |format|
      format.json { render json: {
        transactions: @transactions,
        categories:   @categories,
        bills:        @bills
      }}
      format.html
    end
  end

  def create_transaction
    @transaction = current_user_profile.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save!
        format.html { redirect_to root_path, notice: "Movement was successfully created." }
        format.json { render :index, status: :created, location: @transaction }
        format.js
      else
        format.html { redirect_to dashboard_index_url, alert: @transaction.errors.full_messages }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_account
    @account = current_user_profile.accounts.new(account_params)

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
