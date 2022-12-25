class Bill < ApplicationRecord
  enum status: %i(pending paid)
  enum bill_type: %i(pay receive)

  validates :due_pay, :title, presence: true
  validates :value, presence: true, numericality: { greater_than: 0 }

  has_many :transactions, dependent: :destroy
end
