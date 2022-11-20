# == Schema Information
#
# Table name: recurrences
#
#  id              :bigint           not null, primary key
#  user_profile_id :bigint
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("BRL"), not null
#  pay             :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'test_helper'

class RecurrenceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
