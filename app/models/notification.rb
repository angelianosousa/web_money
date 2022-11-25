# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  user_profile_id :bigint
#  title           :string
#  description     :string
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Notification < ApplicationRecord
  belongs_to :user_profile

  scope :unread, -> (user_profile_id) { where(user_profile_id: user_profile_id, read: false) }
  scope :read, -> (user_profile_id) { where(user_profile_id: user_profile_id, read: true) }

  paginates_per 10

end
