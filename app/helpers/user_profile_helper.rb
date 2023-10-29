# frozen_string_literal: true

# Helper
module UserProfileHelper
  def flash_class(level)
    if level == 'notice'
      'success'
    else
      'danger'
    end
  end

  def achieve_icon(achieve)
    icon_mapping = {
      'money_movement' => 'fa-solid fa-money-bill-transfer',
      'money_managed' => 'fa-solid fa-sack-dollar',
      'budget_reached' => 'fa-solid fa-hand-holding-dollar'
    }

    icon_mapping[achieve.code]
  end
end
