# == Schema Information
#
# Table name: achievements
#
#  id              :bigint           not null, primary key
#  code            :integer
#  goal            :integer
#  message         :string
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
  enum code: %i[]
  belongs_to :user_profile
end

# Conquistas
# + 10 Transações
# + 50 Transações
# + 100 Transações

# + R$ 1000 Geridos na plataforma
# + R$ 3000 Geridos na plataforma
# + R$ 5000 Geridos na plataforma

# + 1 Orçamento alcançado

# + 1 Primeira conta paga antes do vencimento
# + 5 Contas pagas antes do vencimento

