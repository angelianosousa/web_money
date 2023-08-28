module BudgetsHelper
  def budget_options_for_select
    current_profile.budgets.map { |budget| ["#{budget.objective_name} - #{Money.from_amount(budget.goals_price_cents).format}", budget.id] }
  end
end
