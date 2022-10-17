# == Schema Information
#
# Table name: transactions
#
#  id              :bigint           not null, primary key
#  recurrence_id   :bigint
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  date            :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#  move_type       :integer          not null
#  category_id     :bigint           not null
#
FactoryBot.define do
  factory :transaction do
    # recurrence_id { Recurrence.all.sample.id }
    # user_profile { UserProfile.all.sample.id }
    # category_id { Category.all.sample.id }
    # association :recurrence
    recurrence
    user_profile
    category
    title { Faker::Restaurant.name }
    price_cents { rand(100..1000) }
    date { Faker::Date.in_date_period }
  end
end
