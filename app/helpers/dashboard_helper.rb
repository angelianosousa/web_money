module DashboardHelper
  def navlink_dashboard
    link_to dashboard_index_path, class:'navbar-brand navbar-link mb-3' do
      "#{t '.title'} - #{l(Date.today, format: :short)}".html_safe
    end
  end

  def dropdown_item_dashboard(text, target: '', icon:)
    link_to '#', class: "btn btn-outline-dark dropdown-item py-2", data: { toggle: "modal", target: "#{target}"} do
      "#{fontawesome_icon(text, icon)}".html_safe
    end
  end
end