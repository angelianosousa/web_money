# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("USD"), not null
#  user_profile_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :account do
    title { "MyString" }
    value { "9.99" }
    user_profile { nil }
  end
end
