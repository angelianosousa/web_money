# frozen_string_literal: true

module DashboardHelper
  def dropdown_item_dashboard(text, icon:, target: '')
    link_to '#', class: 'btn btn-outline-dark dropdown-item py-2', data: { toggle: 'modal', target: target } do
      fontawesome_icon(text, icon).to_s.html_safe
    end
  end
end
