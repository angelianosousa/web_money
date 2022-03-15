FactoryBot.define do
  factory :recurrence do
    # user_profile_id {  }
    # category_id {  }
    user_profile
    category
    title { Faker::Restaurant.name  }
    price_cents { rand(100..1000) }
    date_expire { Faker::Date.in_date_period }
  end
end