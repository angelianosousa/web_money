module AccountsHelper
  def accounts_options_for_select
    current_profile.accounts.collect { |account| [ "#{account.title} #{humanized_money_with_symbol account.price_cents}", account.id ] }
  end
end
