class Category < ApplicationRecord
  has_many :recurrences

  scope :category_sumatory, ->(title_category, recurrence_title){ 
    find_by_title(title_category).recurrences.group(:title).sum(:value) 
  }

  scope :all_recipes, -> (){ 
    first.recurrences.sum(:value)
  }

  scope :all_expenses, -> (){ 
    second.recurrences.sum(:value)
  }

  scope :category_per_date_expire, ->(category, period = "Dia"){ 
    if period.nil?
      Recurrence.where(category_id: category).group_by_day(:date_expire).sum(:value)  
    elsif period == "Semana"
      Recurrence.where(category_id: category).group_by_week(:date_expire).sum(:value)  
    elsif period == "Mês"
      Recurrence.where(category_id: category).group_by_month(:date_expire).sum(:value)  
    end
  }

  scope :balance, ->(){ 
    group(:title).includes(:recurrences).sum(:value)
  }

  scope :min_and_max_recipes, ->(){ 
    { minimo: first.recurrences.minimum(:value), máximo: first.recurrences.maximum(:value) }
  }

  scope :min_and_max_expenses, ->(){ 
    { minimo: second.recurrences.minimum(:value), máximo: second.recurrences.maximum(:value) }
  }
end
