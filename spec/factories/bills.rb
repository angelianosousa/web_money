# == Schema Information
#
# Table name: bills
#
#  id              :bigint           not null, primary key
#  bill_type       :integer
<<<<<<< HEAD
#  due_pay         :date             default(Mon, 03 Jul 2023)
=======
#  due_pay         :date             default(Sun, 02 Jul 2023)
>>>>>>> c9876f03bb79936da91557c8848e90aed8ff910f
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
    title { "MyString" }
    value { "9.99" }
    due_pay { "2022-12-25" }
    bill_type { 1 }
    status { 1 }
  end
end
