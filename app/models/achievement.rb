# == Schema Information
#
# Table name: achievements
#
#  id              :bigint           not null, primary key
#  code            :integer
#  description     :string
#  goal            :jsonb
#  reached         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_profile_id :bigint           not null
#
# Indexes
#
#  index_achievements_on_user_profile_id  (user_profile_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_profile_id => user_profiles.id)
#
class Achievement < ApplicationRecord
  enum code: %i[money_movement money_managed budget_reached bill_in_day profile_time]
  belongs_to :user_profile
end

# Achievements
# Money Movement
# + 10 Transações adicionadas
# + 50 Transações adicionadas
# + 100 Transações adicionadas

# Moeny Managed
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
