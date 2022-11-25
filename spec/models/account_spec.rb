# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  title           :string
#  price_cents     :integer          default(0), not null
#  price_currency  :string           default("USD"), not null
#  user_profile_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
