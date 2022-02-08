class UserProfile < ApplicationRecord
  belongs_to :user
  has_many :recurrences, dependent: :destroy
  has_many :transactions, dependent: :destroy
end
