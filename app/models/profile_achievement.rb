# frozen_string_literal: true

# == Schema Information
#
# Table name: profile_achievements
#
#  id              :bigint           not null, primary key
#  points_reached  :integer          default(0), not null
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
  validates :points_reached, numericality: { greater_or_equal_than: 0, only_integer: true }
end
