class Transaction < ApplicationRecord
  belongs_to :recurrence

  paginates_per 12
end
