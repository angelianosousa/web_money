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
end
