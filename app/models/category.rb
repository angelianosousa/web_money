class Category < ApplicationRecord
  has_many :recurrences

  validates :title, :badge, uniqueness: true

  scope :category_sumatory, ->(title_category, user_profile){ 
    find_by_title(title_category).recurrences.where(user_profile: user_profile).includes(:transactions).group_by_month(:date_expire, series: false, format: "%b %Y").sum(:value) 
  }

  scope :all_recipes, -> (user_profile){ 
    first.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:value)
  }

  scope :all_expenses, -> (user_profile){ 
    second.recurrences.where(user_profile: user_profile).includes(:transactions).sum(:value)
  }

  scope :balance, ->(user_profile, all_recipes, all_expenses){ 
    { 'Receita': all_recipes, 
      'Despesa': all_expenses }
  }
end
