# frozen_string_literal: true

# == Schema Information
#
# Table name: budgets
#
#  id                   :bigint           not null, primary key
#  date_limit           :datetime
#  goals_price_cents    :integer          default(0), not null
#  goals_price_currency :string           default("BRL"), not null
#  objective_name       :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_profile_id      :bigint           not null
#
# Indexes
#
#  index_budgets_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Budget < ApplicationRecord
  belongs_to :user_profile

  has_many :transactions, dependent: :destroy

  # Money Rails
  monetize :goals_price_cents
  register_currency :brl

  validates :goals_price_cents, presence: true,
                                numericality: { greater_or_equal_than: 1 }

  validates :objective_name, presence: true, uniqueness: { scope: :user_profile_id }

  def title
    date_limit.present? ? "#{Money.from_amount(goals_price_cents).format} | #{objective_name}" : objective_name
  end

  def progress
    transactions.any? ? (transactions.sum(:price_cents).to_f / goals_price_cents).to_f * 100 : 0
  end

  def self.finished(user_profile)
    budgets = []
    budgets.push user_profile.budgets.map do |b|
      return b if b.progress.round(2) >= 100
    end

    budgets
  end
end
