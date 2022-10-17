# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  recurrence_id   :bigint
#  user_profile_id :bigint
#  title           :string
#  description     :string
#  read            :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
