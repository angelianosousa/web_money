# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  description :string
#  read        :boolean          default(FALSE)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user

  validates :description, :title, presence: true

  scope :unread, ->(user_id) { where(user_id: user_id, read: false) }
  scope :read, ->(user_id) { where(user_id: user_id, read: true) }

  paginates_per 10
end
