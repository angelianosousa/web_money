FactoryBot.define do
  factory :user_profile do
    user
    name { Faker::FunnyName.three_word_name }
  end
end