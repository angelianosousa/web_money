module AccountsHelper
  def accounts_options_for_select
    current_user_profile.accounts.collect { |account| [ "#{account.title} #{humanized_money_with_symbol account.price_cents}", account.id ] }
  end

  def navlink_account
    link_to accounts_path, class:"navbar-brand navbar-link mb-3" do
      "#{t('.current_balance', balance: humanized_money_with_symbol(current_user_profile.accounts.sum(:price_cents)))}".html_safe
    end
  end
end
