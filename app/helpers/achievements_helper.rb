# frozen_string_literal: true

# Helper
module AchievementsHelper
  def help_button(achieve)
    title = I18n.t("users.registrations.achievements.codes.#{achieve.code.parameterize}")
    data = { container: 'body', content: achieve.how_to_earn_points, placement: 'top', trigger: 'focus',
             animation: 'true' }
    profile_points = ProfileAchievement.find_by(achievement: achieve, user: current_user)&.points_reached

    content_tag :button, class: 'btn btn-success btn-sm btn-round popover-achieve-info', title: title.html_safe,
                         data: data do
      "#{profile_points} / #{achieve.points}"
    end
  end
end
