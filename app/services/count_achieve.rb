# frozen_string_literal: true

class CountAchieve < ApplicationService
  def initialize(profile, achieve_code)
    super
    @profile = profile
    @achieve = Achievement.find_by(code: achieve_code)
  end

  def call
    @achieve.reached += 1
    @achieve.save
  end
end
