# frozen_string_literal: true

# CountAchievePoints Service
class CountAchievePoints < ApplicationService
  def initialize(user, achieve_code)
    super()
    @user        = user
    @achievement = Achievement.find_by(code: achieve_code, level: :silver)
    @achievement = Achievement.find_by(code: achieve_code, level: :golden)  if @achievement.finished?(@user)
    @achievement = Achievement.find_by(code: achieve_code, level: :diamond) if @achievement.finished?(@user)

    @user_achievement = @user.profile_achievements.find_by(achievement: @achievement)
  end

  def call
    sum_points
    @user_achievement.save!
    @user_achievement
  end

  def sum_points
    case @achievement.code
    when 'money_managed'
      @user_achievement.points_reached += 10
    when 'money_movement'
      @user_achievement.points_reached += 10
    when 'budget_reached'
      @user_achievement.points_reached += 100
    end
  end
end
