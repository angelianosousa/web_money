class Account < ApplicationRecord
  belongs_to :user_profile
  has_many :transactions, dependent: :destroy

  # Money Rails
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, presence: true

  # Kaminari
  paginates_per 12

  scope :per_period, ->(user_profile, move_type){
    where(user_profile: user_profile, transactions: { move_type: move_type }).includes(transactions: [:category])
  }
end
