module TransactionsHelper
  def transaction_status(transaction_type)
    text, badge_class = (transaction_type == 'recipe') ? ['recipe', 'badge badge-success'] : ['expense', 'badge badge-danger']

    badge_pill(text.upcase, class:"#{badge_class}")
  end

  def value_style(transaction)
    symbol, style = (transaction.category.category_type == 'recipe') ? ['fa fa-arrow-up text-success'] : ['fa fa-arrow-down text-danger']

    content_tag(:p, "#{humanized_money_with_symbol(transaction.price_cents)}",class: "#{symbol}")
  end

  def balance_for_that_day(day)
    recipes  = current_profile.transactions.recipes.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    expenses = current_profile.transactions.expenses.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    
    (recipes - expenses)
  end
end
