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
    case achieve.code
    when 'money_movement'
      'fa-solid fa-money-bill-transfer'
    when 'money_managed'
      'fa-solid fa-sack-dollar'
    when 'budget_reached'
      'fa-solid fa-hand-holding-dollar'
    end
  end
end
