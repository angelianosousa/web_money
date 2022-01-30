class Transaction < ApplicationRecord
  belongs_to :recurrence

  paginates_per 12

  scope :_search_, ->(title, page){ 
    where("lower(title) LIKE ?", "%#{title.downcase}%")
    .page(page)
  }
end
