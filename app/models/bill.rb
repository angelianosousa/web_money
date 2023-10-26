# frozen_string_literal: true

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
class Bill < ApplicationRecord
  enum status: %i[pending paid]
  enum bill_type: %i[recipe expense]

  validates :status, :bill_type, :due_pay, :title, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 1 }

  belongs_to :user_profile
  has_many :transactions, dependent: :destroy

  monetize :price_cents
  register_currency :brl

  paginates_per 9

  scope :recipes, ->  { where(bill_type: :recipe).includes(:transactions) }
  scope :expenses, -> { where(bill_type: :expense).includes(:transactions) }
end
