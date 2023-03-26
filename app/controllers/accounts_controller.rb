class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = current_user_profile.accounts.page(params[:page])
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = current_user_profile.accounts.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_url, flash: { success: t('.success') } }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { redirect_to accounts_url, status: :unprocessable_entity, flash: { error: @account.errors.full_messages } }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to accounts_url, flash: { success: t('.success') } }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity, flash: { error: @account.errors.full_messages } }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_transaction
    @account      = current_user_profile.accounts.find(params[:account_id])
    @category     = current_user_profile.categories.find(params[:category_id])

    @account.transactions.create!(
      account_id: @account.id,
      user_profile: current_user_profile,
      description: params[:description],
      price_cents: params[:price_cents].to_i,
      category: @category,
      date: Date.today.to_datetime
    )
    
    if @account.save!
      redirect_to accounts_url, flash: { success: t('.success') }
    else
      redirect_to accounts_url, flash: { error: @account.errors.full_messages }
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, flash: { success: t('.success') } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user_profile.accounts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:title, :price_cents, :user_profile_id)
    end
end
