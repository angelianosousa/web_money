module BillsHelper
  def bill_payment(status, font_size: '12px')
    text, badge_class = (status == 'paid') ? ['PAID', 'badge badge-success'] : ['PENDING', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}", style:"font-size: #{font_size}")
  end

  def bill_due_status(bill, font_size: '12px')
    text, badge_class = (bill.due_pay > Date.today) ? ["IN DAY", 'badge badge-primary'] : ["OVERPASS", 'badge badge-warning']

    badge_pill(text, class:"#{badge_class} mx-auto my-auto", style: "font-size: #{font_size}")
  end

  def bill_type_status(status)
    text, badge_class = (status == 'receive') ? ['TO RECEIVE', 'badge badge-success'] : ['TO PAY', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}")
  end
end
