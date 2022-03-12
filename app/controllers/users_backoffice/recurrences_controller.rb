class UsersBackoffice::RecurrencesController < UsersBackofficeController
  before_action :set_recurrence, only: %i[ edit update destroy ]

  # GET /recurrences or /recurrences.json
  def index
    unless params[:title] || params[:category_id]
      @recurrences = Recurrence.where(user_profile_id: current_user.user_profile.id).order(id: :desc).page(params[:page])
    else
      @recurrences = Recurrence._search_(params[:title], params[:page], current_user.user_profile.id, params[:category_id])
    end
  end

  def payment
    @recurrence = Recurrence.find(params[:recurrence_id])

    @transaction = Transaction.new(
      recurrence_id: @recurrence.id,
      user_profile_id: @recurrence.user_profile_id,
      category_id: @recurrence.category_id,
      title: "Pagamento - #{@recurrence.title}",
      price_cents: "#{@recurrence.price_cents}",
      date: Date.today.to_datetime
    )
    
    if @transaction.save!
      @recurrence.update(pay: true)
      redirect_to users_backoffice_recurrences_url, notice: "Pagamento registrado com sucesso!"
    else
      redirect_to users_backoffice_recurrences_url, alert: @recurrence.errors.full_messages
    end
  end

  # GET /recurrences/1/edit
  def edit
  end

  # POST /recurrences or /recurrences.json
  def create
    @recurrence = Recurrence.new(recurrence_params)
    @recurrence.user_profile = current_user.user_profile

    respond_to do |format|
      if @recurrence.save
        format.html { redirect_to users_backoffice_recurrences_url, notice: "Conta criada com sucesso!" }
        format.json { render :index, status: :created, location: @recurrence }
      else
        format.html { redirect_to users_backoffice_recurrences_url, alert: @recurrence.errors }
        format.json { render json: @recurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurrences/1 or /recurrences/1.json
  def update
    respond_to do |format|
      if @recurrence.update(recurrence_params)
        format.html { redirect_to users_backoffice_recurrences_url, notice: "Conta atualizada com sucesso!" }
        format.json { redirect_to users_backoffice_recurrences_url, status: :ok, location: @recurrence }
      else
        format.html { render :edit, alert: @recurrence.errors.full_messages }
        format.json { render json: @recurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurrences/1 or /recurrences/1.json
  def destroy
    @recurrence.destroy

    respond_to do |format|
      format.html { redirect_to users_backoffice_recurrences_url, notice: "Conta apagada com sucesso!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recurrence
      @recurrence = Recurrence.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recurrence_params
      params.require(:recurrence).permit(:user_profile_id, :category_id, :title, :price_cents, :date_expire)
    end
end
