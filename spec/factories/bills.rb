# == Schema Information
#
# Table name: bills
#
#  id          :bigint           not null, primary key
#  bill_type   :integer
#  due_pay     :date             default(Fri, 30 Dec 2022)
#  price_cents :decimal(, )
#  status      :integer          default("pending")
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
