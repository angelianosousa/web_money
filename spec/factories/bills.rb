# == Schema Information
#
# Table name: bills
#
#  id              :bigint           not null, primary key
#  bill_type       :integer
#  due_pay         :date
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
FactoryBot.define do
  factory :bill do
    user_profile
    title { Faker::Lorem.word }
    price_cents { rand(100..5000) }
    due_pay { Faker::Date.between(from: 12.month.ago.beginning_of_month, to: Date.today) }
    bill_type { %w[recipe expense].sample }
    status { :pending }
  end
end
