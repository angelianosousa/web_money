# frozen_string_literal: true

# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  date            :date
#  description     :text
#  move_type       :integer          default("recipe"), not null
#  price_cents     :integer          not null
#  price_currency  :string           default("BRL"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :bigint
#  bill_id         :bigint
#  budget_id       :bigint
#  category_id     :bigint
#  user_profile_id :bigint
#
# Indexes
#
#  index_transactions_on_account_id       (account_id)
#  index_transactions_on_bill_id          (bill_id)
#  index_transactions_on_budget_id        (budget_id)
#  index_transactions_on_category_id      (category_id)
#  index_transactions_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (bill_id => bills.id)
#  fk_rails_...  (budget_id => budgets.id)
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
