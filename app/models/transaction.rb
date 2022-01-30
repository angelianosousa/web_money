class Transaction < ApplicationRecord
  belongs_to :recurrence

  # Validations
  validates :title, :date, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  scope :_search_, ->(title, page){ 
    where("lower(title) LIKE ?", "%#{title.downcase}%")
    .page(page)
  }
end
