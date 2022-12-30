class UsersBackoffice::BillsController < UsersBackofficeController
  before_action :set_bill, only: %i[ show edit update destroy ]

  # GET /bills or /bills.json
  # FIXME | Filtro não está funcionando como deveria
  def index
    @q = Bill.ransack(params[:q])

    @bills = @q.result.includes(:transactions).page(params[:page]).order(:due_pay)
  end

  # GET /bills/1 or /bills/1.json
  def show
    @transactions = @bill.transactions.page(params[:page]).order(:date)
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills or /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to users_backoffice_bills_path, notice: "Bill was successfully created." }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_transaction
    @bill         = Bill.find(params[:bill_id])
    @account      = Account.find(params[:account_id])
    @category     = Category.find(params[:category_id])
    @user_profile = current_user.user_profile

    @bill.transactions.create!(
      account_id: @account.id,
      user_profile: @user_profile,
      description: params[:description],
      price_cents: params[:price_cents].to_i,
      category: @category,
      date: Date.today.to_datetime
    )

    @bill.status = :paid
    
    if @bill.save!
      redirect_to users_backoffice_bills_url, notice: "Paymment was successfully added!"
    else
      redirect_to users_backoffice_bills_url, alert: @bill.errors.full_messages
    end
  end

  # PATCH/PUT /bills/1 or /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to users_backoffice_bills_path, notice: "Bill was successfully updated." }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1 or /bills/1.json
  def destroy
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to users_backoffice_bills_path, notice: "Bill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bill_params
      params.require(:bill).permit(:title, :price_cents, :due_pay, :bill_type, :status)
    end
end
