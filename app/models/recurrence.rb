class Recurrence < ApplicationRecord
  belongs_to :user_profile
  has_many :transactions, dependent: :destroy
end
