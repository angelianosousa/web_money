# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("USD"), not null
#  date            :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#  category_id     :bigint           not null
#  account_id      :bigint           not null
#  description     :text
#
require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
