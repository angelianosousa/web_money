class Category < ApplicationRecord
  has_many :recurrences

  validates :title, :badge, uniqueness: true

  scope :category_sumatory, ->(title_category, user_profile){ 
    find_by_title(title_category).recurrences.where(user_profile: user_profile).includes(:transactions).group(:title).sum(:value) 
  }

  scope :all_recipes, -> (user_profile){ 
    first.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:value)
  }

  scope :all_expenses, -> (user_profile){ 
    second.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:value)
  }
end
