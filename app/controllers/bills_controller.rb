# frozen_string_literal: true

# Bills Entity Controller
class BillsController < ApplicationController
  before_action :set_bill, only: %i[show edit update destroy]

  # GET /bills or /bills.json
  def index
    @q = current_profile.bills.ransack(params[:q])

    @bills = @q.result(distinct: true).includes(:transactions).page(params[:page]).order(status: :asc, due_pay: :desc)
  end

  # GET /bills/1 or /bills/1.json
  def show
    @transactions = @bill.transactions.page(params[:page]).order(id: :desc, date: :asc)
  end

  # GET /bills/1/edit
  def edit; end

  # POST /bills or /bills.json
  def create
    @bill = current_profile.bills.new(bill_params)

    respond_to do |format|
      if @bill.save
        handle_successful_creation(format, bills_path, @bill)
      else
        handle_failed_creation(format, bills_path, @bill)
      end
    end
  end

  def new_transaction
    @bill = find_bill_by(params.delete(:bill_id))
    set_warning_flash_if_bill_already_paid
    @result = create_payment

    handle_new_transaction
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        handle_successful_update(format, bills_path, @bill)
      else
        handle_failed_update(format, edit_bill_path(@bill), @bill)
      end
    end
  end

  # DELETE /bills/1 or /bills/1.json
  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_path, flash: { danger: t('.success') } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bill
    @bill = current_profile.bills.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def bill_params
    params.require(:bill).permit(:user_profile_id, :title, :price_cents, :due_pay, :bill_type, :status)
  end

  def transaction_params
    params.require(:transaction).permit(:account_id, :category_id, :user_profile_id, :description, :price_cents, :date)
  end

  def handle_new_transaction
    if @result
      flash.now[:success] = t('transactions.create.success')
    else
      flash.now[:danger] = @bill.errors.full_messages.to_sentence
    end
  end

  def set_warning_flash_if_bill_already_paid
    flash.now[:warning] = t('.bill_paid') if @bill.paid?
  end

  def create_payment
    CreatePayment.call(current_profile, @bill, params)
  end

  def find_bill_by(params)
    current_profile.bills.find(params)
  end
end
