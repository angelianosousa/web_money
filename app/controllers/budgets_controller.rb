# frozen_string_literal: true

# Budgets Entity Controller
class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[show edit update destroy]

  # GET /budgets or /budgets.json
  def index
    @budgets = current_user.budgets
  end

  # GET /budgets/1/edit
  def edit; end

  # POST /budgets or /budgets.json
  def create
    @budget = current_user.budgets.build(budget_params)

    respond_to do |format|
      if @budget.save
        handle_successful_creation(format, budgets_url, @budget)
      else
        handle_failed_creation(format, budgets_url, @budget)
      end
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        handle_successful_update(format, budgets_url, @budget)
      else
        handle_failed_update(format, edit_budget_url(@budget), @budget)
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy

    redirect_to budgets_url, flash: { success: t('.success') }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_budget
    @budget = current_user.budgets.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def budget_params
    params.require(:budget).permit(:objective_name, :goals_price, :date_limit, :user_id)
  end
end
