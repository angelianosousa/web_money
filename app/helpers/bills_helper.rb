# frozen_string_literal: true

# Helper
module BillsHelper
  def bill_payment(status, font_size: '12px')
    paid    = Bill.human_attribute_name 'bill.status.paid'
    pending = Bill.human_attribute_name 'bill.status.pending'

    text, badge_class = status == 'paid' ? [paid, 'badge badge-success'] : [pending, 'badge badge-danger']

    badge_pill(text.upcase, class: badge_class, style: "font-size: #{font_size}")
  end

  def bill_due_status(bill, font_size: '12px')
    text, badge_class = if bill.due_pay > Date.today
                          ['in day',
                           'badge badge-primary']
                        else
                          ['overpass', 'badge badge-warning']
                        end

    badge_pill(text.upcase, class: "#{badge_class} mx-auto my-auto", style: "font-size: #{font_size}")
  end

  def bill_type_status(status)
    _, fontawesome_class = if status == 'recipe'
                             ['',
                              'bill-status-recipe fa fa-arrow-up']
                           else
                             ['',
                              'bill-status-expense fa fa-arrow-down']
                           end

    content_tag :i, '', class: fontawesome_class, style: 'font-size: 10px;'
  end

  def bill_type_options_for_select
    translations_scope = %i[helpers bill_type_options_for_select]

    Bill.bill_types.map do |status_key, _value|
      [t(status_key, scope: translations_scope), status_key]
    end
  end

  def bill_status_options_for_select
    translations_scope = %i[helpers bill_status_options_for_select]

    Bill.statuses.map do |status_key, _value|
      [t(status_key, scope: translations_scope), status_key]
    end
  end
end
