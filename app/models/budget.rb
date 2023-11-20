# frozen_string_literal: true

# == Schema Information
#
# Table name: budgets
#
#  id                   :bigint           not null, primary key
#  date_limit           :datetime
#  goals_price_cents    :integer          not null
#  goals_price_currency :string           default("BRL"), not null
#  objective_name       :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_budgets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Budget < ApplicationRecord
  belongs_to :user

  has_many :transactions, dependent: :destroy

  # Money Rails
  monetize :goals_price_cents
  register_currency :brl

  validates :goals_price, numericality: { greater_or_equal_than: 1 }

  validates :objective_name, presence: true, uniqueness: { scope: :user_id }

  def title
    "#{Money.from_cents(goals_price).format} | #{objective_name}"
  end

  def progress
    transactions.any? ? (transactions.sum(:price_cents).to_f / goals_price_cents).to_f * 100 : 0
  end

  def self.finished(user)
    budgets = []
    user.budgets.map do |b|
      return budgets.push b if b.progress.round(2) >= 100
    end

    budgets
  end
end
