# frozen_string_literal: true

# Helper
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
    symbol, color = ['fa fa-arrow-up', 'green'] if transaction.recipe?
    symbol, color = ['fa fa-arrow-down', 'red'] if transaction.expense?
    symbol, color = ['fa fa-exchange', 'blue']  if transaction.transfer?

    content_tag :span, class: symbol.to_s, id: "transaction#{transaction.id}", style: "color: #{color};font-family: Poppins; font-size: 15px." do
      humanized_money_with_symbol(transaction.price_cents).to_s
    end
  end

  def balance_for_that_day(day)
    recipes  = current_profile.transactions.recipes.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)
    expenses = current_profile.transactions.expenses.where('date <= ?', day.to_datetime.end_of_day).sum(:price_cents)

    (recipes - expenses)
  end
end
