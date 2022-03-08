class Category < ApplicationRecord
  has_many :recurrences

  validates :title, :badge, uniqueness: true

  scope :recipes_sumatory, ->(user_profile){ 
    first.recurrences.where(user_profile: user_profile).includes(:transactions).group(:title).sum(:price_cents) 
  }

  scope :expenses_sumatory, ->(user_profile){ 
    second.recurrences.where(user_profile: user_profile).includes(:transactions).group(:title).sum(:price_cents) 
  }

  scope :all_recipes, -> (user_profile){ 
    first.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:price_cents)
  }

  scope :all_expenses, -> (user_profile){ 
    second.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:price_cents)
  }

  scope :balance, ->(recipes, expenses){
    recipes - expenses
  }
end
