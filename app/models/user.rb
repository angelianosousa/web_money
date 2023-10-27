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
#  username               :string
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
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable :recoverable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :menu_icon_profile, resize_to_limit: [50, 50]
  end

  has_many :transactions,         dependent: :destroy
  has_many :categories,           dependent: :destroy
  has_many :accounts,             dependent: :destroy
  has_many :bills,                dependent: :destroy
  has_many :budgets,              dependent: :destroy
  has_many :profile_achievements, dependent: :destroy
  has_many :achievements, -> { order(:code) }, through: :profile_achievements, dependent: :destroy

  def building_profile
    User.transaction do
      categories.create(title: 'Despesa X', category_type: 'expense')
      categories.create(title: 'Receita X', category_type: 'recipe')

      self.achievements = Achievement.all
    end
  rescue ActiveRecord::RecordInvalid => e
    p e.message
  end
end
