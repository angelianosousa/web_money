module DashboardHelper
  def navlink_dashboard
    link_to dashboard_index_path, class:'navbar-brand navbar-link mb-3' do
      "#{t '.title'} - #{l(Date.today, format: :short)}".html_safe
    end
  end
end