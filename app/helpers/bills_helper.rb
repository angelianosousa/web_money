module BillsHelper
  def bill_payment(status, font_size: '12px')
    text, badge_class = (status == 'paid') ? ['paid', 'badge badge-success'] : ['pending', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}", style:"font-size: #{font_size}")
  end

  def bill_due_status(bill, font_size: '12px')
    text, badge_class = (bill.due_pay > Date.today) ? ["in day", 'badge badge-primary'] : ["overpass", 'badge badge-warning']

    badge_pill(text, class:"#{badge_class} mx-auto my-auto", style: "font-size: #{font_size}")
  end

  def bill_type_status(status)
    text, badge_class = (status == 'receive') ? ['to receive', 'badge badge-success'] : ['to pay', 'badge badge-danger']

    badge_pill(text, class:"#{badge_class}")
  end
end
