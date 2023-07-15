class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show edit update destroy ]

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
  def edit
  end

  # POST /bills or /bills.json
  def create
    @bill = current_profile.bills.build(bill_params)

    if @bill.save
      flash.now[:notice] = [t('.notice')]
    else
      flash.now[:alert] = @bill.errors.full_messages
    end
  end

  def new_transaction
    @bill = current_profile.bills.find(params.delete(:bill_id))

    if @bill.paid?
      flash.now[:warning] = [t('.bill_paid')]
      return
    end
    
    @bill = CreatePayment.call(current_profile, @bill, params)
    
    if @bill.persisted?
      flash.now[:notice] = [t('transactions.create.notice')]
    else
      flash.now[:alert] = @bill.errors.full_messages
    end
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bills_path, flash: { notice: [t('.notice')] } }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity, flash: { alert: @bill.errors.full_messages } }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1 or /bills/1.json
  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to bills_path, flash: { notice: [t('.notice')] } }
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
end
