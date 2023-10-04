# frozen_string_literal: true

class CountAchieve < ApplicationService
  def initialize(profile, achieve_code)
    @profile = profile
    @achieve = Achievement.find_by(code: achieve_code)
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
