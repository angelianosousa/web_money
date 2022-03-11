class Transaction < ApplicationRecord
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
  scope :_search_, ->(title, page, user_profile_id, order_per_attribute, up_down){ 
    unless order_per_attribute
      where("lower(title) LIKE ? and user_profile_id = ?", "%#{title.downcase}%", "#{user_profile_id}").includes(:recurrence => :category).page(page)
    else
      order("#{order_per_attribute}": :"#{up_down}").page(page)
    end
  }

  RECIPES = 1
  EXPENSES = 2
  scope :transactions_recipes_per_date, -> (user_profile){
    where(user_profile: user_profile, category_id: RECIPES).select(:title, :price_cents).group_by_day(:created_at, format: "%b %Y").sum(:price_cents)
  }

  scope :transactions_recipes, -> (user_profile){ 
    where(user_profile: user_profile, category_id: RECIPES).sum(:price_cents)
  }

  scope :transactions_expenses, -> (user_profile){ 
    where(user_profile: user_profile, category_id: EXPENSES).sum(:price_cents)
  }
end
