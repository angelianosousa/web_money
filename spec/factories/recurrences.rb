# == Schema Information
#
# Table name: recurrences
#
#  id              :bigint           not null, primary key
#  user_profile_id :bigint
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  pay             :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
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
