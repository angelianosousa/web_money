# == Schema Information
#
# Table name: profile_achievements
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  achievement_id  :bigint           not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_profile_achievements_on_achievement_id   (achievement_id)
#  index_profile_achievements_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (achievement_id => achievements.id)
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class ProfileAchievement < ApplicationRecord
  belongs_to :user_profile
  belongs_to :achievement
end
