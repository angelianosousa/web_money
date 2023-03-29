# == Schema Information
#
# Table name: accounts
#
#  id              :bigint           not null, primary key
#  price_cents     :decimal(, )      default(0.0), not null
#  price_currency  :string           default("BRL"), not null
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_accounts_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Account < ApplicationRecord
  belongs_to :user_profile
  has_many :transactions, dependent: :destroy

  # Money Rails
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }

  # Kaminari
  paginates_per 12
end
