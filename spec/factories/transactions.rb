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