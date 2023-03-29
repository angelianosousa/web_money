class BillsController < ApplicationController
  before_action :set_bill, only: %i[ show edit update destroy ]

  # GET /bills or /bills.json
  def index
    @q = current_user_profile.bills.ransack(params[:q])

    @bills = @q.result(distinct: true).includes(:transactions).page(params[:page]).order(:due_pay)
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
    @bill = current_user_profile.bills.build(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bills_path, flash: { success: t('.success') } }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :index, status: :unprocessable_entity, flash: { alert: @bill.errors.full_messages } }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_transaction
    @bill         = current_user_profile.bills.find(params[:bill_id])
    @account      = current_user_profile.accounts.find(params[:account_id])
    @category     = current_user_profile.categories.find(params[:category_id])

    @bill.transactions.build(
      account_id: @account.id,
      user_profile: current_user_profile,
      description: params[:description],
      price_cents: params[:price_cents].to_i,
      category: @category,
      date: Date.today.to_datetime
    )

    @bill.status  = :paid
    @bill.due_pay += 1.month
    
    if @bill.save!
      redirect_to bills_url, flash: { success: t('.success') }
    else
      redirect_to bills_url, flash: { alert: @bill.errors.full_messages }
    end
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bills_path, flash: { success: t('.success') } }
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
      format.html { redirect_to bills_path, flash: { success: t('.success') } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = current_user_profile.bills.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bill_params
      params.require(:bill).permit(:title, :price_cents, :due_pay, :bill_type, :status)
    end
end
