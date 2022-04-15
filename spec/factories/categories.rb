FactoryBot.define do
  factory :category do
    title { Faker::Movie.quote }
    badge { %i[primary warning secondary info dark].sample }
  end
end