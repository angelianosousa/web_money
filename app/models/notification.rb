class Notification < ApplicationRecord
  belongs_to :recurrence

  scope :uread_notification, -> (user_profile) { where(user_profile: user_profile, read: false) }
end
