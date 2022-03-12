class Transaction < ApplicationRecord
  # Constant variables
  RECIPES = 1
  EXPENSES = 2

  # Record Relations
  belongs_to :recurrence
  belongs_to :category
  belongs_to :user_profile

  # Money Rails 
  monetize :price_cents
  register_currency :brl

  # Validations
  validates :title, :date, presence: true

  # Kaminari
  paginates_per 12

  # Scope Methods
  # Search any transactions
  scope :_search_transactions, ->(title, user_profile_id, page){ 
    where("lower(title) LIKE ? and user_profile_id = ?", "%#{title.downcase}%", "#{user_profile_id}").includes(:recurrence => :category).page(page)
  }

  # Search transactions separete by recurrence
  scope :_search_transactions_per_recurrence, -> (recurrence, user_profile_id, page){ 
    where("recurrence_id = #{recurrence} and user_profile_id = #{user_profile_id}").includes(:category).page(page)
  }

  # Search transactions recipes classified per date
  scope :transactions_recipes_per_date, -> (user_profile){
    where(user_profile: user_profile, category_id: RECIPES).select(:title, :price_cents).group_by_day(:created_at, format: "%b %Y").sum(:price_cents)
  }

  # Filter per transactions recipes 
  scope :transactions_recipes, -> (user_profile){ 
    where(user_profile: user_profile, category_id: RECIPES).sum(:price_cents)
  }

  # Filter per transactions expenses
  scope :transactions_expenses, -> (user_profile){ 
    where(user_profile: user_profile, category_id: EXPENSES).sum(:price_cents)
  }
end
