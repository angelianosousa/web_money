module UsersBackoffice::AccountsHelper
  def accounts_options_for_select
    Account.all.collect { |account| [ "#{account.title} #{humanized_money_with_symbol account.price_cents}", account.id ] }
  end
end
