# frozen_string_literal: true

# Helper
module BudgetsHelper
  def budget_options_for_select
    current_user.budgets.map do |budget|
      ["#{budget.objective_name} - #{humanized_money_with_symbol(budget.goals_price)}", budget.id]
    end
  end
end
