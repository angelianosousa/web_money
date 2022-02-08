module RecurrencesHelper
  def categories_select
    Category.all.collect { |c| [c.title, c.id]}
  end

  def count_transactions(recurrence)
    recurrence.transactions.count
  end
end
