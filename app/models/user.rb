# frozen_string_literal: true

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
    UserProfile.transaction do
      user_profile = UserProfile.create(user_id: User.last.id)

      user_profile.accounts.create(title: 'Banco X', price_cents: 0)
      user_profile.accounts.create(title: 'Banco Y', price_cents: 0)

      user_profile.categories.create(title: 'Despesa X', category_type: 'expense')
      user_profile.categories.create(title: 'Receita X', category_type: 'recipe')
    end
  rescue ActiveRecord::RecordInvalid => e
    p e.message
  end
end
