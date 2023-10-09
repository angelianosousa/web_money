# frozen_string_literal: true

# == Schema Information
#
# Table name: achievements
#
#  id             :bigint           not null, primary key
#  code           :integer
#  description    :string
#  icon           :string
#  level          :integer          default("golden")
#  points_reached :integer          default(0)
#  total_points   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Achievement < ApplicationRecord
  enum code: %i[money_movement money_managed budget_reached]
  enum level: %i[silver golden diamond]

  validates :description, :icon, :code, :level, presence: true
  validates :points_reached, :total_points, numericality: { greater_or_equal_than: 0, only_integer: true }

  has_many :profile_achievements
  has_many :user_profiles, through: :profile_achievements, source: :user_profile

  scope :finished, ->     { where('points_reached >= total_points') }
  scope :not_finished, -> { where('points_reached <= total_points') }

  def how_to_earn_points
    case code
    when 'money_movement'
      'Cada movimentação vale 10 pontos'.html_safe
    when 'money_managed'
      'O valor de cada transação vale 10 pontos'.html_safe
    when 'budget_reached'
      'Cada meta batida vale 100 pontos'.html_safe
    end
  end

  def conquest?
    points_reached >= total_points
  end
end

# Achievements
# Money Movement
# + 10 Transações adicionadas
# + 50 Transações adicionadas
# + 100 Transações adicionadas

# Money Managed
# + R$ 1000 Geridos na plataforma
# + R$ 3000 Geridos na plataforma
# + R$ 5000 Geridos na plataforma

# Budget Reached
# + 1 Orçamento alcançado
# + 3 Orçamentos alcançados

# Bill in day
# + 1 Primeira conta paga antes do vencimento
# + 5 Contas pagas antes do vencimento

# Profile Time
# + 1 Mês de Web Money
# + 3 Meses de Web Money
