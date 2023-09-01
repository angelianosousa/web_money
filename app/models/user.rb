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
        user_profile = user_profile.create(user_id: id)
  
        user_profile.accounts.create(title:"Banco X", price_cents: 0)
        user_profile.accounts.create(title:"Banco Y", price_cents: 0)
  
        user_profile.categories.create(title: 'Despesa X', category_type: 'expense')
        user_profile.categories.create(title: 'Receita X', category_type: 'recipe')

        user_profile.achievements.create(message: , code: :money_movement, goal:, reached:)
        user_profile.achievements.create(message: , code: :money_managed, goal:, reached:)
        user_profile.achievements.create(message: , code: :budget_reached, goal:, reached:)
        user_profile.achievements.create(message: , code: :bill_in_day, goal:, reached:)
        user_profile.achievements.create(message: , code: :profile_time, goal:, reached:)
      end
    rescue ActiveRecord::RecordInvalid => e
      p e.message
    end
  end

end
