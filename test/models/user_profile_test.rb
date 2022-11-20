# == Schema Information
#
# Table name: user_profiles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
