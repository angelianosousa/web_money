module TransactionsHelper
  def transaction_status(transaction_move_type)
    text, badge_class = (transaction_move_type == 'recipe') ? ['RECIPE', 'badge badge-success'] : ['EXPENSE', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}")
  end

  def value_style(transaction)
    style = (transaction.move_type == 'recipe') ? 'color: green' : 'color: red'

    content_tag(:p, humanized_money_with_symbol(transaction.price_cents), style: style)
  end

  def balance_for_that_day(day)
    recipes  = Transaction.recipes.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    expenses = Transaction.expenses.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    accounts = Account.sum(:price_cents)
    balance  = accounts + (recipes - expenses)
  end
end
