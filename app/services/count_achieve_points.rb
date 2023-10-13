# frozen_string_literal: true

# CountAchievePoints Service
class CountAchievePoints < ApplicationService
  def initialize(profile, achieve_code)
    super()
    @profile = profile
    @achievement = Achievement.find_by(code: achieve_code, level: :silver)
    @achievement = Achievement.find_by(code: achieve_code, level: :golden) if @achievement.finished?(@profile)
    @achievement = Achievement.find_by(code: achieve_code, level: :diamond) if @achievement.finished?(@profile)

    @profile_achievement = ProfileAchievement.find_by(user_profile: @profile, achievement: @achievement)
  end

  def call
    sum_points
    @profile_achievement.save
  end

  def sum_points
    case @achievement.code
    when 'money_movement'
      @profile_achievement.points_reached += 10
    when 'money_managed'
      @profile_achievement.points_reached += 10
    when 'budget_reached'
      @profile_achievement.points_reached += 100
    end
  end
end
