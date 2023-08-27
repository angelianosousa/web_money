class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]

  # GET /budgets or /budgets.json
  def index
    @budgets = current_profile.budgets
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budget = current_profile.budgets.build
  end

  # GET /budgets/1/edit
  def edit
  end

  # POST /budgets or /budgets.json
  def create
    @budget = current_profile.budgets.build(budget_params)

    if @budget.save
      redirect_to budgets_url, flash: { success: "Budget was successfully created." }
    else
      redirect_to budgets_url, flash: { danger: @budget.errors.full_messages.to_sentence }
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    if @budget.update(budget_params)
      redirect_to budgets_url, flash: { success: "Budget was successfully updated." }
    else
      redirect_to edit_budget_path(@budget), flash: { danger: @budget.errors.full_messages.to_sentence }
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy

    redirect_to budgets_url, flash: { success: "Budget was successfully destroyed." }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = current_profile.budgets.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.require(:budget).permit(:objective_name, :goals_price_cents, :date_limit, :user_profile_id)
    end
end
