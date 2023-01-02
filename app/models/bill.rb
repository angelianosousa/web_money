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
class Bill < ApplicationRecord
  enum status: %i(pending paid)
  enum bill_type: %i(pay receive)

  validates :due_pay, :title, presence: true
  validates :price_cents, presence: true, numericality: { greater_than: 0 }

  has_many :transactions, dependent: :destroy

  monetize :price_cents
  register_currency :usd

  paginates_per 10
end
