# == Schema Information
#
# Table name: user_profiles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserProfile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  has_many :recurrences, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :categories, dependent: :destroy
end
