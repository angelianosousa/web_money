# frozen_string_literal: true

# CountAchievePoints Service
class CountAchievePoints < ApplicationService
  def initialize(profile, achieve_code)
    super()
    @profile = profile
    @achieve = @profile.achievements.not_finished.find_by(code: achieve_code, level: :silver)
    @achieve = @profile.achievements.not_finished.find_by(code: achieve_code, level: :golden) if @achieve.conquest?
    @achieve = @profile.achievements.not_finished.find_by(code: achieve_code, level: :diamond) if @achieve.conquest?
  end

  def call
    sum_points
    @achieve.save
  end

  def sum_points
    case @achieve.code
    when 'money_movement'
      @achieve.points_reached += 10
    when 'money_managed'
      @achieve.points_reached += 10
    when 'budget_reached'
      @achieve.points_reached += 100
    end
  end
end
