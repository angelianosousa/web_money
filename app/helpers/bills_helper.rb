module BillsHelper
  def bill_payment(status)
    text, badge_class = (status == 'paid') ? ['PAID', 'badge badge-success'] : ['PENDING', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}")
  end

  def bill_due_status(bill)
    text, badge_class = (bill.due_pay > Date.today) ? ["IN DAY", 'badge badge-success'] : ["OVERPASS", 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}")
  end

  def bill_type_status(status)
    text, badge_class = (status == 'receive') ? ['TO RECEIVE', 'badge badge-success'] : ['TO PAY', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}")
  end
end
