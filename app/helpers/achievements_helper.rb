# frozen_string_literal: true

# Helper
module AchievementsHelper
  def help_button(achieve)
    title = I18n.t("user_profile.edit.achievements.codes.#{achieve.code.parameterize}")
    data = { container: 'body', content: achieve.how_to_earn_points, placement: 'top' }

    content_tag :button, class: 'btn btn-success btn-sm btn-round popover-test', title: title, data: data do
      "#{achieve.points_reached} / #{achieve.total_points}"
    end
  end
end
