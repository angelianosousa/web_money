class UsersBackoffice::AccountsController < UsersBackofficeController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all.page(params[:page])
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to users_backoffice_accounts_url, notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    @account.user_profile_id = current_user.user_profile.id
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to users_backoffice_accounts_url, notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_transaction
    @account      = Account.find(params[:account_id])
    @category     = Category.find(params[:category_id])
    @user_profile = current_user.user_profile

    @account.transactions.create!(
      account_id: @account.id,
      user_profile: @user_profile,
      description: params[:description],
      price_cents: params[:price_cents].to_i,
      move_type: params[:move_type],
      category: @category,
      date: Date.today.to_datetime
    )
    
    if @account.save!
      redirect_to users_backoffice_accounts_url, notice: "Pagamento registrado com sucesso!"
    else
      redirect_to users_backoffice_accounts_url, alert: @account.errors.full_messages
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:title, :price_cents, :user_profile_id)
    end
end
