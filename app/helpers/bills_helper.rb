module BillsHelper
  def bill_payment(status, font_size: '12px')
    text, badge_class = (status == 'paid') ? ['paid', 'badge badge-success'] : ['pending', 'badge badge-danger']

    badge_pill(text.upcase, class:"#{badge_class}", style:"font-size: #{font_size}")
  end

  def bill_due_status(bill, font_size: '12px')
    text, badge_class = (bill.due_pay > Date.today) ? ["in day", 'badge badge-primary'] : ["overpass", 'badge badge-warning']

    badge_pill(text.upcase, class:"#{badge_class} mx-auto my-auto", style: "font-size: #{font_size}")
  end

  def bill_type_status(status)
    text, fontawesome_class = (status == 'receive') ? ['', 'bill-status-recipe fa fa-arrow-up'] : ['', 'bill-status-expense fa fa-arrow-down']

    content_tag :i, '', class:"#{fontawesome_class}", style:'font-size: 10px;'
  end

  def navlink_bill
    link_to bills_path, class:'navbar-brand navbar-link mb-3' do
      "#{t '.title'}"
    end
  end

  def bill_type_options_for_select
    translations_scope = %i[helpers bill_type_options_for_select]

    Bill.bill_types.map do |status_key, value|
      [t(status_key, scope: translations_scope), value]
    end
  end
end
