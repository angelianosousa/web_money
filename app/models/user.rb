# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  after_create :building_profile

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :user_profile
  
  def building_profile
    begin
      UserProfile.transaction do
        user_profile = UserProfile.create(user_id: User.last.id)
  
        user_profile.accounts.create(title:"Banco X", price_cents: 0)
        user_profile.accounts.create(title:"Banco Y", price_cents: 0)
  
        user_profile.categories.create(title: 'Despesa X', category_type: 'expense')
        user_profile.categories.create(title: 'Receita X', category_type: 'recipe')

        achievements = [
          'Parabéns, você está construindo um hábito muito importante para a saude financeira',
          'Parabéns, continue gerindo seu patrimônio!!',
          'Parabéns, cumprir suas metas é um passo importante para construir o futuro!!',
          'Continue pagando suas contas em dia',
          'Continue gerindo seu dinheiro com a Web Money'
        ]

        user_profile.achievements.create(description: achievements[0], code: :money_movement, goal: { level_01: 10, level_02: 50, level_03: 100 }, reached: 0)
        user_profile.achievements.create(description: achievements[1], code: :money_managed, goal: { level_01: 1000, level_02: 3000, level_03: 5000 }, reached: 0)
        user_profile.achievements.create(description: achievements[2], code: :budget_reached, goal: { level_01: 1, level_02: 3, level_03: 5 }, reached: 0)
        user_profile.achievements.create(description: achievements[3], code: :bill_in_day, goal: { level_01: 1, level_02: 3, level_03: 5 }, reached: 0)
        user_profile.achievements.create(description: achievements[4], code: :profile_time, goal: { level_01: 1, level_02: 3, level_03: 5 }, reached: 0)
      end
    rescue ActiveRecord::RecordInvalid => e
      p e.message
    end
  end

end
