class DashboardController < ApplicationController

  def index
    params[:q] ||= { user_profile_id_eq: current_profile.id, date_gteq: Date.today.beginning_of_month, date_lteq: Date.today.end_of_month }

    @q = current_profile.transactions.ransack(params[:q])

    @transactions    = @q.result(distinct: true)

    @categories      = @transactions.includes(:category).group(:title).sum(:price_cents)
    @bills           = @transactions.where.not(bill_id: nil).includes(:bill).group(:title).sum(:price_cents)
    @current_balance = @transactions.recipes.sum(:price_cents) - @transactions.expenses.sum(:price_cents)
  end

  def create_transaction
    @transaction = current_profile.transactions.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to root_path, flash: { notice: t('.notice') } }
        format.json { render :index, status: :created, location: @transaction }
        format.js
      else
        format.html { redirect_to dashboard_index_url, flash: { alert: @transaction.errors.full_messages } }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_account
    @account = current_profile.accounts.build(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to root_path, flash: { notice: t('.notice') } }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render root_path, status: :unprocessable_entity, flash: { alert: @account.errors.full_messages } }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_account
    @bill = current_profile.bills.build(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to root_path, flash: { notice: t('.notice') } }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render root_path, status: :unprocessable_entity, flash: { alert: @bill.errors.full_messages } }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
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

  def bill_params
    params.require(:bill).permit(:title, :price_cents, :due_pay, :bill_type, :status)
  end
end
