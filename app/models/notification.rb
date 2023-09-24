# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  description     :string
#  read            :boolean          default(FALSE)
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint
#
# Indexes
#
#  index_notifications_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Notification < ApplicationRecord
  belongs_to :user_profile

  validates :description, :title, presence: true

  scope :unread, ->(user_profile_id) { where(user_profile_id: user_profile_id, read: false) }
  scope :read, ->(user_profile_id) { where(user_profile_id: user_profile_id, read: true) }

  paginates_per 10
end
