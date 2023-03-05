module TransactionsHelper
  def transaction_status(transaction_type)
    text, badge_class = (transaction_type == 'recipe') ? ['recipe', 'badge badge-success'] : ['expense', 'badge badge-danger']

    badge_pill(text.upcase, class:"#{badge_class}")
  end

  def value_style(transaction)
    style = (transaction.category.category_type == 'recipe') ? 'color: green' : 'color: red'

    content_tag(:p, humanized_money_with_symbol(transaction.price_cents), style: style)
  end

  def balance_for_that_day(day)
    recipes  = current_user_profile.transactions.recipes.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    expenses = current_user_profile.transactions.expenses.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    accounts = current_user_profile.accounts.sum(:price_cents)
    balance  = recipes - expenses
  end
end
