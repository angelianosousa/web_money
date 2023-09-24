# frozen_string_literal: true

module UserProfileHelper
  def flash_class(level)
    if level == 'notice'
      'success'
    else
      'danger'
    end
  end
end
