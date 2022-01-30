class Recurrence < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_many :transactions, dependent: :destroy

  paginates_per 12

  scope :_search_, ->(title, page){ 
    where("lower(title) LIKE ?", "%#{title.downcase}%")
    .page(page)
   }
end
