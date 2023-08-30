# frozen_string_literal: true

module TransactionsHelper
  def transaction_status(transaction_type)
    text, badge_class = if transaction_type == 'recipe'
                          ['recipe',
                           'badge badge-success']
                        else
                          ['expense', 'badge badge-danger']
                        end

    badge_pill(text.upcase, class: badge_class.to_s)
  end

  def value_style(transaction)
    symbol = (transaction.category.recipe?) ? ['fa fa-arrow-up'] : ['fa fa-arrow-down']

    content_tag :span, class: symbol.to_s, id: "transaction#{transaction.id}" do
      humanized_money_with_symbol(transaction.price_cents).to_s
    end
  end

  def balance_for_that_day(day)
    recipes  = current_profile.transactions.recipes.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    expenses = current_profile.transactions.expenses.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)

    (recipes - expenses)
  end
end
