# == Schema Information
#
# Table name: user_profiles
#
#  id         :bigint           not null, primary key
#  name       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_user_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserProfile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar do |attachable|
    attachable.variant :menu_icon_profile, resize_to_limit: [50, 50]
  end

  has_many :transactions,         dependent: :destroy
  has_many :categories,           dependent: :destroy
  has_many :accounts,             dependent: :destroy
  has_many :bills,                dependent: :destroy
  has_many :budgets,              dependent: :destroy
  has_many :profile_achievements, dependent: :destroy
  has_many :achievements, through: :profile_achievements, dependent: :destroy
end
