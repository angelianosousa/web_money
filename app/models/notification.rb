class Notification < ApplicationRecord
  belongs_to :recurrence
  belongs_to :user_profile

  scope :unread, -> (user_profile_id) { where(user_profile_id: user_profile_id, read: false) }
  scope :read, -> (user_profile_id) { where(user_profile_id: user_profile_id, read: true) }

  paginates_per 10

end
