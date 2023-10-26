# frozen_string_literal: true

# Helper
module BudgetsHelper
  def budget_options_for_select
    current_user.budgets.map do |budget|
      ["#{budget.objective_name} - #{Money.from_amount(budget.goals_price_cents).format}", budget.id]
    end
  end
end
