# == Schema Information
#
# Table name: bills
#
#  id          :bigint           not null, primary key
#  bill_type   :integer
#  due_pay     :date             default(Sun, 26 Feb 2023)
#  price_cents :decimal(, )
#  status      :integer          default("pending")
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Bill, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
