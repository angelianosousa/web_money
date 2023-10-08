# frozen_string_literal: true

# Helper
module AccountsHelper
  def accounts_options_for_select
    current_profile.accounts.order(price_cents: :desc).collect do |account|
      ["#{account.title} #{humanized_money_with_symbol(account.price_cents)}", account.id]
    end
  end
end
