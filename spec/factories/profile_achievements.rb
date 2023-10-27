FactoryBot.define do
  factory :profile_achievement do
    user_id        { create(:user).id }
    achievement_id { create(:achievement).id }
    points_reached { 0 }

    trait :invalid do
      user_id        {}
      achievement_id {}
      points_reached {}
    end
  end
end