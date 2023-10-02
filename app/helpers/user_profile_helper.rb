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
end
