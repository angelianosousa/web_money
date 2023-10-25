# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_accounts_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
FactoryBot.define do
  factory :account do
    user_profile_id { create(:user_profile).id }
    title           { Faker::Bank.name }
    price_cents     { rand(200..2000) }

    trait :invalid do
      user_profile_id {}
      title           {}
      price_cents     {}
    end
  end
end
