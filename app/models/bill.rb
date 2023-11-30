# frozen_string_literal: true

# == Schema Information
#
# Table name: bills
#
#  id             :bigint           not null, primary key
#  bill_type      :integer
#  due_pay        :date
#  price_cents    :integer          default(0), not null
#  price_currency :string           default("BRL"), not null
#  status         :integer          default("pending")
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_bills_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Bill < ApplicationRecord
  enum status: %i[pending paid]
  enum bill_type: %i[recipe expense]

  monetize :price_cents
  register_currency :brl

  validates :status, :bill_type, :due_pay, :title, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :title, uniqueness: { case_sensitive: true, scope: :user_id }

  belongs_to :user
  has_many :transactions, dependent: :destroy

  paginates_per 9

  scope :recipes, ->  { where(bill_type: :recipe).includes(:transactions) }
  scope :expenses, -> { where(bill_type: :expense).includes(:transactions) }
end
