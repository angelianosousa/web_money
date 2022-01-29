module RecurrencesHelper
  def card_style(recurrence)
    if recurrence.category == "Receita" 
      "badge badge-success"
    else
       "badge badge-danger"
    end
  end
end
