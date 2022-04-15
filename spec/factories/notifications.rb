FactoryBot.define do
  factory :notification do
    user_profile
    recurrence
    title { Faker::Restaurant.type }
    description { Faker::Restaurant.description }
    read { %i[true false].sample }
  end
end