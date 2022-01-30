class Recurrence < ApplicationRecord
  belongs_to :user_profile
  belongs_to :category
  has_many :transactions, dependent: :destroy

  # Validations
  validates :title, :value, :date_expire, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  scope :_search_, ->(title, page){ 
    where("lower(title) LIKE ?", "%#{title.downcase}%")
    .page(page)
   }
end
