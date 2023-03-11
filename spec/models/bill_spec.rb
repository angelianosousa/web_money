# == Schema Information
#
# Table name: bills
#
#  id              :bigint           not null, primary key
#  bill_type       :integer
#  due_pay         :date             default(Thu, 09 Mar 2023)
#  price_cents     :decimal(, )
#  status          :integer          default("pending")
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_bills_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
require 'rails_helper'

RSpec.describe Bill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
