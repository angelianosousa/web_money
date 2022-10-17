module RecurrencesHelper
  def categories_select
    Category.all.collect { |c| [c.title, c.id]}
  end

  def count_transactions(recurrence)
    recurrence.transactions.count
  end

  def color_recurrence(recurrence)
    recurrence.category == 1 ? 'background-color:#2E8B57;color:#F0F8FF;' : 'background-color:#DC143C;color:#F0F8FF;'
  end
end
