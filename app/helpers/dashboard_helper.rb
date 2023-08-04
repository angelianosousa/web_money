module DashboardHelper
  def dropdown_item_dashboard(text, target: '', icon:)
    link_to '#', class: "btn btn-outline-dark dropdown-item py-2", data: { toggle: "modal", target: target } do
      "#{fontawesome_icon(text, icon)}".html_safe
    end
  end
end