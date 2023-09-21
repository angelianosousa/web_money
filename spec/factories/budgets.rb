# == Schema Information
#
# Table name: budgets
#
#  id                   :bigint           not null, primary key
#  date_limit           :datetime
#  goals_price_cents    :integer          default(0), not null
#  goals_price_currency :string           default("BRL"), not null
#  objective_name       :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_profile_id      :bigint           not null
#
# Indexes
#
#  index_budgets_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
FactoryBot.define do
  factory :budget do
    objective_name { Faker::Commerce.department }
    goals_price { rand(1000.00..9999.00) }
    date_limit { Faker::Date.forward(days: 60) }
    user_profile
  end
end
