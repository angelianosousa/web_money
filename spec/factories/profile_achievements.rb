# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_achievements
#
#  id             :bigint           not null, primary key
#  points_reached :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  achievement_id :bigint           not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_profile_achievements_on_achievement_id  (achievement_id)
#  index_profile_achievements_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (achievement_id => achievements.id)
#  fk_rails_...  (user_id => users.id)
#
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
