# == Schema Information
#
# Table name: bills
#
#  id              :bigint           not null, primary key
#  bill_type       :integer
#  due_pay         :date             default(Sun, 09 Apr 2023)
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
class Bill < ApplicationRecord
  enum status: %i[pending paid]
  enum bill_type: %i[pay receive]

  validates :due_pay, :title, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }

  belongs_to :user_profile
  has_many :transactions, dependent: :destroy

  monetize :price_cents
  register_currency :brl

  paginates_per 10
end
